"""Given: the "step functions" "state machine" had a "dynamodb" task configured"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsDynamodbTestClient
from ..constants import (
    ROLE_ARN,
    TEST_ITEM_KEY,
    TEST_PK,
    TEST_SM,
    TEST_TABLE,
    _dynamodb_put_item_definition,
    _sm_arn,
)


@given('the "step functions" "state machine" had a "dynamodb" task configured')
def sm_has_dynamodb_task(lws_session):
    """Create a state machine with a DynamoDB PutItem task; update if it already exists."""
    try:
        StepfunctionsDynamodbTestClient(lws_session).create_table()
    except Exception:
        pass
    try:
        StepfunctionsDynamodbTestClient(lws_session)._sfn.create_state_machine(
            name=TEST_SM,
            definition=_dynamodb_put_item_definition(TEST_TABLE, TEST_PK, TEST_ITEM_KEY),
            roleArn=ROLE_ARN,
        )
    except Exception:
        StepfunctionsDynamodbTestClient(lws_session)._sfn.update_state_machine(
            stateMachineArn=_sm_arn(),
            definition=_dynamodb_put_item_definition(TEST_TABLE, TEST_PK, TEST_ITEM_KEY),
        )
