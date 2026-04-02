"""Given: the "step functions" "execution"'s state machine has a configured "sqs" task"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSqsTestClient
from ..constants import TEST_QUEUE, _sm_arn, _sqs_task_definition


@given('the execution\'s state machine has a configured "SQS" task')
@given('the "step functions" "execution"\'s state machine has a configured "sqs" task')
def execution_sm_has_sqs_task(lws_session):
    """Update the state machine to have an SQS sendMessage task configured."""
    # Arrange
    try:
        StepfunctionsSqsTestClient(lws_session).create_queue()
    except Exception:
        pass
    queue_url = lws_session.queue_url(TEST_QUEUE)
    # Act
    StepfunctionsSqsTestClient(lws_session)._sfn.update_state_machine(
        stateMachineArn=_sm_arn(), definition=_sqs_task_definition(queue_url)
    )
