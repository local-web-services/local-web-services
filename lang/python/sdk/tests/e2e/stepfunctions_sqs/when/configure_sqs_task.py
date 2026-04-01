"""When: a "SQS" send-message task is configured on the state machine"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_QUEUE, _sm_arn, _sqs_task_definition


@when('a "SQS" send-message task is configured on the state machine')
def configure_sqs_task(lws_session, world):
    # Arrange
    queue_url = lws_session.queue_url(TEST_QUEUE)
    # Act
    try:
        world["result"] = lws_session.client("stepfunctions").update_state_machine(
            stateMachineArn=_sm_arn(), definition=_sqs_task_definition(queue_url)
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
