"""When: an "SQS" send-message task is configured on the state machine"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import StepfunctionsSqsTestClient
from ..constants import TEST_QUEUE, _sm_arn, _sqs_task_definition


@when('an "SQS" send-message task is configured on the state machine')
def configure_sqs_task(lws_session, world):
    try:
        world["result"] = StepfunctionsSqsTestClient(lws_session)._sfn.update_state_machine(
            stateMachineArn=_sm_arn(), definition=_sqs_task_definition(TEST_QUEUE)
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
