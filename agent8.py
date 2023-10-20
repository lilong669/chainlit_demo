import langchain
from dotenv import load_dotenv
from langchain.agents import initialize_agent, AgentType
from langchain.chat_models import ChatOpenAI
from datetime import timedelta, datetime
import chainlit as cl
from utils.custom_tools import CustomTrinoListTable, CustomTrinoTableSchema, CustomTrinoSqlQuery, CustomTrinoSqlCheck, CustomTrinoTableJoin

# 加载.env文件中的环境变量
load_dotenv()
langchain.debug = True
today = (datetime.now()).strftime("%Y%m%d")
yeaterday = (datetime.now() - timedelta(days=1)).strftime("%Y%m%d")
today_d = (datetime.now()).strftime("%Y-%m-%d")
yeaterday_d = (datetime.now() - timedelta(days=1)).strftime("%Y-%m-%d")
custom_prefix = f""" You are an agent designed to interact with a Trino SQL database.
Please do not answer others questions,use Chinese to answer questions,think it step by step. 
NOTE: 
data rule:
date string format YYYYMMDD. for example, today is {today}, then yeaterday is {yeaterday}, and so on.
date string format YYYY-MM-DD. for example, today is {today_d}, then yeaterday is {yeaterday_d}, and so on.
column dt is table data version string, not a business date.
sql rule:
sql generation not need to end with ; only sql itself.
get answer from single sql after plan logics step by step. 
You have access to the following tools:"""


@cl.on_chat_start
async def start():
    # Initialize model
    model = ChatOpenAI(model_name="gpt-3.5-turbo", temperature=0, verbose=False, streaming=True)

    custom_tool_list = [CustomTrinoListTable(), CustomTrinoTableSchema(), CustomTrinoSqlQuery(), CustomTrinoSqlCheck(), CustomTrinoTableJoin()]

    agent_executor = initialize_agent(
        custom_tool_list,
        llm=model,
        agent=AgentType.ZERO_SHOT_REACT_DESCRIPTION,
        verbose=True,
        max_iterations=6,
        agent_kwargs={"prefix": custom_prefix},
        handle_parsing_errors="Check your output and make sure it conforms"
    )
    cl.user_session.set("agent", agent_executor)
    # Send the initial message
    elements = [
        cl.Text(name="提问：", content="计算订单明细表的dt为昨天,销售日期为本月的总销售数量", display="inline"),
        cl.Text(name="我能生成SQL脚本：", content=f"SELECT SUM(num) AS total_sales_quantity FROM gjdw.dw_sale_tr_goods_dt WHERE dt = '{today}' AND dates >= '2023-10-01' AND dates <= '2023-10-31'", display="inline", language="SQL"),
        cl.Text(name="最终结果：", content="订单明细表的dt为昨天，销售日期为本月的总销售数量是0。", display="inline"),
    ]
    content = "Hi,我是 Trino SQL Agent ,我能帮助你查询trino数据库。您可以向我提问，例如："
    await cl.Message(content=content, elements=elements).send()


@cl.on_message
async def main(message: cl.Message):
    agent = cl.user_session.get("agent")  # type: #AgentExecutor
    cb = cl.LangchainCallbackHandler(stream_final_answer=True)
    print(message)
    await cl.make_async(agent.run)(message, callbacks=[cb])

# def ask(input: str) -> str:
#     print("-- Serving request for input: %s" % input)
#     try:
#         response = agent_executor.run(input)
#     except Exception as e:
#         response = str(e)
#         if response.startswith("Could not parse LLM output: `"):
#             response = response.removeprefix("Could not parse LLM output: `").removesuffix("`")
#     return response


# agent_executor.run(" table gjdw.dw_sale_tr_goods_dt has column named bill_code ?")
# ask("计算订单明细表的dt为昨天,销售日期为本月初的总销售数量")
