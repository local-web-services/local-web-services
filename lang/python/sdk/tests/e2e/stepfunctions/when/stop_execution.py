"""When: a running execution is stopped"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import StepfunctionsTestClient


@when("a running execution is stopped")
def stop_execution(lws_session, world):
    try:
        execution_arn = world.get("execution_arn", "")
        resp = StepfunctionsTestClient(lws_session).stop_execution(executionArn=execution_arn)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
