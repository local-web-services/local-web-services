"""Given: the state machine has a "SQS" task configured"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSqsTestClient
from ..constants import ROLE_ARN, TEST_QUEUE, TEST_SM, _sm_arn, _sqs_task_definition


@given('the state machine has a "SQS" task configured')
def sm_has_sqs_task(lws_session):
    """Create a state machine with an SQS sendMessage task; update if it already exists."""
    # Arrange
    client = StepfunctionsSqsTestClient(lws_session)
    try:
        client.create_queue()
    except Exception:  # noqa: BLE001
        pass
    queue_url = lws_session.queue_url(TEST_QUEUE)
    # Act
    try:
        client._sfn.create_state_machine(
            name=TEST_SM, definition=_sqs_task_definition(queue_url), roleArn=ROLE_ARN
        )
    except Exception:  # noqa: BLE001
        client._sfn.update_state_machine(
            stateMachineArn=_sm_arn(), definition=_sqs_task_definition(queue_url)
        )
