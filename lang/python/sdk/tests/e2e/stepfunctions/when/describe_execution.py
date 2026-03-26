"""When: an execution is described"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import StepfunctionsTestClient


@when("an execution is described")
def describe_execution(lws_session, world):
    try:
        execution_arn = world.get("execution_arn", "")
        resp = StepfunctionsTestClient(lws_session).describe_execution(executionArn=execution_arn)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
