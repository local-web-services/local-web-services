"""When: a running "step functions" "execution" attempts to get an item that does not exist and the execution fails"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import StepfunctionsDynamodbTestClient
from ..constants import (
    TEST_INPUT,
    TEST_PK,
    TEST_TABLE,
    _dynamodb_get_item_definition,
    _sm_arn,
)


@when(
    'a running "step functions" "execution" attempts to get an item that does not exist and the execution fails'
)
def execution_gets_item_not_found(lws_session, world):
    try:
        StepfunctionsDynamodbTestClient(lws_session).create_table()
    except Exception:
        pass
    try:
        lws_session.client("stepfunctions").update_state_machine(
            stateMachineArn=_sm_arn(),
            definition=_dynamodb_get_item_definition(TEST_TABLE, TEST_PK, "nonexistent-key-1"),
        )
    except Exception:
        pass
    try:
        resp = lws_session.client("stepfunctions").start_execution(
            stateMachineArn=_sm_arn(), input=TEST_INPUT
        )
        world["result"] = resp
        world["execution_arn"] = resp["executionArn"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
