from langchain.chains import RetrievalQA
from langchain.chat_models import ChatOpenAI
from langchain.embeddings import OpenAIEmbeddings, CacheBackedEmbeddings
from langchain.llms import OpenAI
from langchain.document_loaders import TextLoader
from dotenv import load_dotenv
from langchain.prompts import PromptTemplate
from langchain.storage import LocalFileStore
from langchain.text_splitter import CharacterTextSplitter
from langchain.vectorstores.chroma import Chroma
from langchain.indexes import VectorstoreIndexCreator

# 加载.env文件中的环境变量
load_dotenv()
# Load the document, split it into chunks, embed each chunk and load it into the vector store.
path = r'C:\Users\lilong\PycharmProjects\chainlit\source\1.sql'
loader = TextLoader(path, encoding='utf-8')

# Initialize model
model = ChatOpenAI(model_name="gpt-3.5-turbo", temperature=0, verbose=True)

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
texts = text_splitter.split_documents(loader.load())
# 制作向量数据库
db = Chroma.from_documents(texts, cached_embedder)
retriever = db.as_retriever(search_kwargs={"k": 1})

prompt_template = (
    "[INST] <<SYS>>\n"
    "You are a helpful DB assistant. 你是一个乐于助人的数据库助手。\n"
    "<</SYS>>\n\n"
    "{context}\n{question} [/INST]"
)
PROMPT = PromptTemplate(
    template=prompt_template, input_variables=["context", "question"]
)
chain_type_kwargs = {"prompt": PROMPT}
qa = RetrievalQA.from_chain_type(
    llm=model,
    chain_type="stuff",
    retriever=retriever,
    chain_type_kwargs=chain_type_kwargs)
query = 'bdp_job_table_info 结构'
print(qa.run(query))
