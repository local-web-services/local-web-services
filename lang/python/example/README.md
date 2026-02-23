# local-web-services Python SDK — Example Project

An example project showing how to test an AWS Step Functions workflow using the [local-web-services Python SDK](https://github.com/local-web-services/local-web-services-python-sdk).

## What this example does

- Defines a simple `process_order` function that starts a Step Functions execution and waits for it to complete
- Uses `LwsSession` to run a local Step Functions emulator during tests — no AWS account or credentials required
- Tests pass on any machine with Python and `local-web-services` installed

## Project structure

```
src/
  order_processor.py   # Production code — plain boto3, no test-specific config
tests/
  test_order_processor.py  # Tests using LwsSession
```

## Prerequisites

```bash
pip install local-web-services
```

## Running the tests

```bash
pip install boto3 local-web-services local-web-services-python-sdk pytest pytest-timeout
pytest tests/ -v
```

## How it works

```python
# tests/test_order_processor.py
from lws_testing import LwsSession
from src.order_processor import process_order

@pytest.fixture(scope="module")
def session():
    with LwsSession() as s:   # starts ldk dev
        yield s

@pytest.fixture(scope="module")
def sfn_client(session):
    # session.client() returns a pre-configured client pointing at the local emulator
    return session.client("stepfunctions")

@pytest.fixture(scope="module")
def state_machine_arn(sfn_client):
    response = sfn_client.create_state_machine(name="OrderProcessor", ...)
    return response["stateMachineArn"]

def test_process_order_returns_order_id(state_machine_arn, sfn_client):
    # Pass the local SFN client — production code accepts an optional client
    # for testability; in production it creates one with default settings
    actual_result = process_order("order-123", state_machine_arn, sfn_client)
    assert actual_result["orderId"] == "order-123"
```

## Links

- [local-web-services](https://github.com/local-web-services/local-web-services) — the core tool
- [Python SDK](https://github.com/local-web-services/local-web-services-python-sdk) — `pip install local-web-services-python-sdk`
