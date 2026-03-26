"""When: a running execution reaches the "SQS" task state and sends a message to the queue"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import StepfunctionsSqsTestClient
from ..constants import TEST_INPUT, _sm_arn


@when('a running execution reaches the "SQS" task state and sends a message to the queue')
def execution_sends_message(lws_session, world):
    try:
        resp = StepfunctionsSqsTestClient(lws_session)._sfn.start_execution(
            stateMachineArn=_sm_arn(), input=TEST_INPUT
        )
        world["result"] = resp
        world["execution_arn"] = resp["executionArn"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
