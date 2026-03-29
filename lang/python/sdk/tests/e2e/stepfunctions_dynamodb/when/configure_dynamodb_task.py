"""When: a DynamoDB PutItem task is configured on the state machine"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_ITEM_KEY, TEST_PK, TEST_TABLE, _dynamodb_put_item_definition, _sm_arn


@when("a DynamoDB PutItem task is configured on the state machine")
def configure_dynamodb_task(lws_session, world):
    try:
        world["result"] = lws_session.client("stepfunctions").update_state_machine(
            stateMachineArn=_sm_arn(),
            definition=_dynamodb_put_item_definition(TEST_TABLE, TEST_PK, TEST_ITEM_KEY),
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
