"""When: the event history of a "step functions" "execution" is retrieved"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when


@when('the event history of a "step functions" "execution" is retrieved')
def get_execution_history(lws_session, world):
    try:
        execution_arn = world.get("execution_arn", "")
        resp = lws_session.client("stepfunctions").get_execution_history(executionArn=execution_arn)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
