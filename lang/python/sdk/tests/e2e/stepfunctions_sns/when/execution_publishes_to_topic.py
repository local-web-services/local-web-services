"""When: a running execution publishes a message to the "SNS" topic and succeeds"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import StepfunctionsSnsTestClient
from ..constants import TEST_INPUT, TEST_TOPIC, _sm_arn, _sns_task_definition


@when('a running execution publishes a message to the "SNS" topic and succeeds')
def execution_publishes_to_topic(lws_session, world):
    try:
        StepfunctionsSnsTestClient(lws_session).create_topic()
    except Exception:
        pass
    try:
        lws_session.client("stepfunctions").update_state_machine(
            stateMachineArn=_sm_arn(), definition=_sns_task_definition(TEST_TOPIC)
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
