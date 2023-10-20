import langchain
from dotenv import load_dotenv
from langchain.agents import initialize_agent, AgentType, ZeroShotAgent
from langchain.callbacks import FinalStreamingStdOutCallbackHandler
from langchain.chat_models import ChatOpenAI
from datetime import timedelta, datetime
import chainlit as cl
from utils.custom_tools import CustomTrinoListTable, CustomTrinoTableSchema, CustomTrinoSqlQuery, CustomTrinoSqlCheck

# 加载.env文件中的环境变量
load_dotenv()
langchain.debug = True
today = (datetime.now()).strftime("%Y%m%d")
yeaterday = (datetime.now() - timedelta(days=1)).strftime("%Y%m%d")
today_d = (datetime.now()).strftime("%Y-%m-%d")
yeaterday_d = (datetime.now() - timedelta(days=1)).strftime("%Y-%m-%d")
custom_prefix = f""" You are an agent designed to interact with a Trino SQL database,Please do not answer others questions. 
NOTE: date string format YYYYMMDD. for example, today is {today}, then yeaterday is {yeaterday}, and so on.
date string format YYYY-MM-DD. for example, today is {today_d}, then yeaterday is {yeaterday_d}, and so on.
You have access to the following tools:"""


@cl.on_chat_start
def start():
    # Initialize model
    model = ChatOpenAI(model_name="gpt-3.5-turbo", temperature=0, verbose=False, streaming=True)

    custom_tool_list = [CustomTrinoListTable(), CustomTrinoTableSchema(), CustomTrinoSqlQuery(), CustomTrinoSqlCheck()]

    agent_executor = initialize_agent(
        custom_tool_list,
        llm=model,
        agent=AgentType.ZERO_SHOT_REACT_DESCRIPTION,
        verbose=True,
        max_iterations=6,
        agent_kwargs={"prefix": custom_prefix},
    )
    cl.user_session.set("agent", agent_executor)


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
