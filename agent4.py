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

custom_suffix = """ You are an agent designed to interact with a Trino SQL database. I should first get uesd tables abount the user question using the doc_get_list_tables tool.
Then I should query the table schema of the table using doc_get_table_schema"""

# Initialize model
model = ChatOpenAI(model_name="gpt-3.5-turbo", temperature=0, verbose=True)
# Slightly tweak the instructions from the default agent
openapi_format_instructions = """Use the following format:

Question: the input question you must answer
Thought: you should always think about what to do
Action: the action to take, should be one of [{tool_names}]
Action Input: what to instruct the AI Action representative.
Observation: The Agent's response
... (this Thought/Action/Action Input/Observation can repeat N times)
Thought: I now know the final answer. User can't see any of my observations, API responses, links, or tools.
Final Answer: the final answer to the original input question with the right amount of detail

When responding with your Final Answer, remember that the person you are responding to CANNOT see any of your Thought/Action/Action Input/Observations, so if there is any relevant information there you need to include it explicitly in your response."""


def get_tool_doc_list_table():
    """查询表和表结构，字段，建表语句等详细信息"""
    # Load the document, split it into chunks, embed each chunk and load it into the vector store.
    path = r'C:\Users\lilong\PycharmProjects\chainlit\source\hive_table_list.txt'
    loader = TextLoader(path, encoding='utf-8')

    # 用文件缓存已经存在的向量，后续可以翻到ES上加速，大量的存贮
    underlying_embeddings = OpenAIEmbeddings()
    fs = LocalFileStore("./test_cache/hive_table_list/")

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
        description="""Input to this tool should be table comment in the user question, output is a comma separated list of table name about the table comment.
    """
    )

    return retriever_tool


def get_tool_doc_table_schema():
    """查询表和表结构，字段，建表语句等详细信息"""
    # Load the document, split it into chunks, embed each chunk and load it into the vector store.
    path = r'C:\Users\lilong\PycharmProjects\chainlit\source\hive_table_column.txt'
    loader = TextLoader(path, encoding='utf-8')

    # 用文件缓存已经存在的向量，后续可以翻到ES上加速，大量的存贮
    underlying_embeddings = OpenAIEmbeddings()
    fs = LocalFileStore("./test_cache/hive_table_column/")

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
        name='doc_get_table_schema',
        description="""Input to this tool should be table name, output is a list of table column with Column,Type,Extra,Comment.
    Be sure that the table actually exist by calling doc_get_list_tables first! 
    """
    )

    return retriever_tool


doc_list_table_tool = get_tool_doc_list_table()
doc_table_schema_tool = get_tool_doc_table_schema()
# query_sql_database_tool, info_sql_database_tool, list_sql_database_tool, query_sql_checker_tool = SQLDatabaseToolkit(db=db, llm=model).get_tools()
# custom_tool_list = [doc_list_table_tool, query_sql_database_tool, info_sql_database_tool,list_sql_database_tool, query_sql_checker_tool]
# custom_tool_list = [doc_list_table_tool, doc_table_schema_tool]
custom_tool_list = [doc_table_schema_tool]
agent_executor = initialize_agent(
    custom_tool_list,
    llm=model,
    agent=AgentType.ZERO_SHOT_REACT_DESCRIPTION,
    verbose=True,
    suffix=custom_suffix,
    max_iterations=5,
    # agent_kwargs={"format_instructions": openapi_format_instructions},
)
agent_executor.run("gjdw.dw_sale_tr_goods_dt")
