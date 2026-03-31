"""When: an "step functions" "execution" of the "step functions" "state machine" is started"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_INPUT, _sm_arn


@when('an "step functions" "execution" of the "step functions" "state machine" is started')
def start_execution(lws_session, world):
    try:
        resp = lws_session.client("stepfunctions").start_execution(
            stateMachineArn=_sm_arn(), input=TEST_INPUT
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
