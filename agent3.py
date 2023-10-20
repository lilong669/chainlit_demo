import langchain
from langchain.chains import RetrievalQA
from langchain.chat_models import ChatOpenAI
from langchain.embeddings import OpenAIEmbeddings, CacheBackedEmbeddings
from langchain.indexes import VectorstoreIndexCreator
from langchain.llms import OpenAI
from langchain.document_loaders import TextLoader
from dotenv import load_dotenv
from langchain.prompts import PromptTemplate
from langchain.storage import LocalFileStore
from langchain.text_splitter import CharacterTextSplitter
from langchain.vectorstores.chroma import Chroma
from langchain.agents import create_sql_agent, AgentType, initialize_agent
from langchain.agents.agent_toolkits import SQLDatabaseToolkit
from langchain.llms.openai import OpenAI
from langchain.utilities import SQLDatabase
from langchain.chat_models import ChatOpenAI
from urllib.parse import quote
from dotenv import load_dotenv
from sqlalchemy import create_engine

# 加载.env文件中的环境变量
load_dotenv()
langchain.debug = True
from langchain.prompts import PromptTemplate

custom_suffix = """ I should first get uesd tables abount the user question using the doc_get_list_tables tool.
Otherwise, I can view the tables in the database to see what I can query.
Then I should query the schema of the most relevant table"""
# TEMPLATE = """你是一个中文AI助手，给定一个输入问题，首先创建一个语法正确的 {dialect} 查询来运行，然后查看查询结果并返回答案。
# 使用中文回答！
# 使用如下格式:
#
# 问题: "问题"
# SQL查询: "SQL查询"
# SQL查询结果: "SQL查询结果"
# 回答: "最终的回答"
#
# 只使用以下表:
#
# {table_info}.
#
# 与问题对应的 SQL 查询的一些示例包括:
#
# {few_shot_examples}
#
# 问题: {input}"""
#
# CUSTOM_PROMPT = PromptTemplate(
#     input_variables=["input", "few_shot_examples", "table_info", "dialect"], template=TEMPLATE
# )
# Initialize database
# 将密码进行 URL 编码
password = quote("P@ssw0rd")
engine = create_engine('hive://hive:hive@')
db = SQLDatabase(engine, schema='gjdw', include_tables=['dw_sale_tr_goods_dt', 'dim_org', 'dw_sale_tr_goods_dt'])
# db = SQLDatabase.from_uri(f'mysql+pymysql://bdp_schedule:{password}@10.8.50.32:3306/bdp_schedule')
# # Pull down prompt
# prompt = CUSTOM_PROMPT
# Initialize model
model = ChatOpenAI(model_name="gpt-3.5-turbo", temperature=0, verbose=True)


def get_tool_doc_list_table():
    """查询表和表结构，字段，建表语句等详细信息"""
    # Load the document, split it into chunks, embed each chunk and load it into the vector store.
    path = r'C:\Users\lilong\PycharmProjects\chainlit\source\hive_table_list'
    loader = TextLoader(path, encoding='utf-8')

    # 用文件缓存已经存在的向量，后续可以翻到ES上加速，大量的存贮
    underlying_embeddings = OpenAIEmbeddings()
    fs = LocalFileStore("./test_cache/")

    cached_embedder = CacheBackedEmbeddings.from_bytes_store(
        underlying_embeddings, fs, namespace=underlying_embeddings.model
    )
    # 用分号切割文件
    text_splitter = CharacterTextSplitter(
        separator=";",
        chunk_size=1000,
        chunk_overlap=200,
        length_function=len,
        is_separator_regex=False,
    )
    # 可以使用向量检索或其他搜索算法来实现搜索逻辑
    index_creator = VectorstoreIndexCreator(
        vectorstore_cls=Chroma,
        embedding=cached_embedder,
        text_splitter=text_splitter
    )
    index = index_creator.from_loaders([loader])
    doc_retriever = index.vectorstore.as_retriever()

    from langchain.agents.agent_toolkits import create_retriever_tool

    retriever_tool = create_retriever_tool(
        doc_retriever,
        name='doc_get_list_tables',
        description="""Input to this tool should be the user question used table name, output is a comma separated list of uesd tables about the question in the database.
    """
    )

    return retriever_tool


retriever_tool = get_tool_doc_list_table()
query_sql_database_tool, info_sql_database_tool, list_sql_database_tool, query_sql_checker_tool = SQLDatabaseToolkit(db=db, llm=model).get_tools()
custom_tool_list = [retriever_tool, query_sql_database_tool, info_sql_database_tool, query_sql_checker_tool]

agent_executor = initialize_agent(
    custom_tool_list,
    llm=model,
    agent=AgentType.ZERO_SHOT_REACT_DESCRIPTION,
    verbose=True,
    suffix=custom_suffix
)
agent_executor.run("销售订单的行数")
