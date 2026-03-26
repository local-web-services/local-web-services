"""Given: the execution's state machine has a configured "SQS" task"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSqsTestClient
from ..constants import TEST_QUEUE, _sm_arn, _sqs_task_definition


@given('the execution\'s state machine has a configured "SQS" task')
def execution_sm_has_sqs_task(lws_session):
    """Update the state machine to have an SQS sendMessage task configured."""
    try:
        StepfunctionsSqsTestClient(lws_session).create_queue()
    except Exception:
        pass
    StepfunctionsSqsTestClient(lws_session)._sfn.update_state_machine(
        stateMachineArn=_sm_arn(), definition=_sqs_task_definition(TEST_QUEUE)
    )
