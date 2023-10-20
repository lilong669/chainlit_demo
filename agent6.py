import langchain
from dotenv import load_dotenv
from langchain.agents import initialize_agent, AgentType, ZeroShotAgent
from langchain.chat_models import ChatOpenAI
from datetime import timedelta, datetime
from utils.custom_tools import CustomTrinoListTable, CustomTrinoTableSchema, CustomTrinoSqlQuery, CustomTrinoSqlCheck
# if column dt in where condition you can write like this:
# where dt='20230101'
# 加载.env文件中的环境变量
load_dotenv()
langchain.debug = True
today = (datetime.now()).strftime("%Y%m%d")
yeaterday = (datetime.now() - timedelta(days=1)).strftime("%Y%m%d")
today_d = (datetime.now()).strftime("%Y-%m-%d")
yeaterday_d = (datetime.now() - timedelta(days=1)).strftime("%Y-%m-%d")
custom_prefix = f""" You are an agent designed to interact with a Trino SQL database. 
NOTE: date string format YYYYMMDD. for example, today is {today}, then yeaterday is {yeaterday}, and so on.
date string format YYYY-MM-DD. for example, today is {today_d}, then yeaterday is {yeaterday_d}, and so on.
You have access to the following tools:"""

# Initialize model
model = ChatOpenAI(model_name="gpt-3.5-turbo", temperature=0, verbose=True)

custom_tool_list = [CustomTrinoListTable(), CustomTrinoTableSchema(), CustomTrinoSqlQuery(), CustomTrinoSqlCheck()]
# Set up the base template
# prompt = CustomPromptTemplate(
#     template=template,
#     tools=custom_tool_list,
#     # This omits the `agent_scratchpad`, `tools`, and `tool_names` variables because those are generated dynamically
#     # This includes the `intermediate_steps` variable because that is needed
#     input_variables=["input", "intermediate_steps"]
# )
agent_executor = initialize_agent(
    custom_tool_list,
    llm=model,
    agent=AgentType.ZERO_SHOT_REACT_DESCRIPTION,
    verbose=True,
    max_iterations=6,
    agent_kwargs={"prefix": custom_prefix},
)


def ask(input: str) -> str:
    print("-- Serving request for input: %s" % input)
    try:
        response = agent_executor.run(input)
    except Exception as e:
        response = str(e)
        if response.startswith("Could not parse LLM output: `"):
            response = response.removeprefix("Could not parse LLM output: `").removesuffix("`")
    return response


# agent_executor.run(" table gjdw.dw_sale_tr_goods_dt has column named bill_code ?")
ask("计算订单明细表的dt为昨天,销售日期为本月初的总销售数量")
