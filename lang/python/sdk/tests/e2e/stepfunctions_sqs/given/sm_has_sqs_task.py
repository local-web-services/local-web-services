"""Given: the state machine has an "SQS" task configured"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSqsTestClient
from ..constants import ROLE_ARN, TEST_QUEUE, TEST_SM, _sm_arn, _sqs_task_definition


@given('the state machine has an "SQS" task configured')
def sm_has_sqs_task(lws_session):
    """Create a state machine with an SQS sendMessage task; update if it already exists."""
    try:
        StepfunctionsSqsTestClient(lws_session)._sfn.create_state_machine(
            name=TEST_SM, definition=_sqs_task_definition(TEST_QUEUE), roleArn=ROLE_ARN
        )
    except Exception:
        StepfunctionsSqsTestClient(lws_session)._sfn.update_state_machine(
            stateMachineArn=_sm_arn(), definition=_sqs_task_definition(TEST_QUEUE)
        )
