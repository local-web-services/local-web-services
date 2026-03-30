"""When: an execution is described"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when


@when("an execution is described")
def describe_execution(lws_session, world):
    try:
        execution_arn = world.get("execution_arn", "")
        resp = lws_session.client("stepfunctions").describe_execution(executionArn=execution_arn)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
