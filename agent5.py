import langchain
from dotenv import load_dotenv
from langchain.agents import initialize_agent, AgentType
from langchain.chat_models import ChatOpenAI

from utils.custom_tools import CustomTrinoListTable, CustomTrinoTableSchema, CustomTrinoSqlQuery, CustomTrinoSqlCheck

# 加载.env文件中的环境变量
load_dotenv()
langchain.debug = True

custom_suffix = """ You are an agent designed to interact with a Trino SQL database. 
Special NOTE: dt=yesterday means dt=date_format(date_trunc('day', current_date) - interval '1' day, '%Y%m%d')
Answer the following questions as best you can. You have access to the following tools:"""
template = """Complete the objective as best you can. You have access to the following tools:

{tools}

Use the following format:

Question: the input question you must answer
Thought: you should always think about what to do
Action: the action to take, should be one of [{tool_names}]
Action Input: the input to the action
Observation: the result of the action
... (this Thought/Action/Action Input/Observation can repeat N times)
Thought: I now know the final answer
Final Answer: the final answer to the original input question

These were previous tasks you completed:



Begin!

Question: {input}
{agent_scratchpad}"""

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
    # suffix=custom_suffix,
    max_iterations=8,
    # agent_kwargs={"format_instructions": custom_suffix},
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
ask("计算dt为昨天的订单明细表的销售日期的最大值")
