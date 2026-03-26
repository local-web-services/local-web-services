"""When: an execution of the state machine is started"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import StepfunctionsOpensearchTestClient
from ..constants import TEST_INPUT, _sm_arn


@when("an execution of the state machine is started")
def start_execution(lws_session, world):
    try:
        resp = StepfunctionsOpensearchTestClient(lws_session)._sfn.start_execution(
            stateMachineArn=_sm_arn(), input=TEST_INPUT
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
