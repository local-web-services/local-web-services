"""When: an execution starts but the "STARTED" event delivery fails because the bus is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_INPUT, _sm_arn


@when('an execution starts but the "STARTED" event delivery fails because the bus is deleted')
def start_execution_event_fails(lws_session, world):
    try:
        resp = lws_session.client("stepfunctions").start_execution(
            stateMachineArn=_sm_arn(), input=TEST_INPUT
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
