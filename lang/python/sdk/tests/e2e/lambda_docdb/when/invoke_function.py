"""When: the Lambda function is invoked"""

from __future__ import annotations

import uuid

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_FUNC


@when("the Lambda function is invoked")
def invoke_function(lws_session, world):
    # Arrange
    invocation_id = str(uuid.uuid4())
    # Act
    try:
        if lws_session.capacity("lambda").is_exhausted():
            lws_session.client("lambda").invoke(FunctionName=TEST_FUNC, Payload=b"{}")
        resp = lws_session.client("lambda").get_function(FunctionName=TEST_FUNC)
        func_state = resp.get("Configuration", {}).get("State", "")
        if func_state != "Active":
            raise RuntimeError(f"Function is not Active: {func_state!r}")
        lws_session.inject_state("lambda", "invocation", invocation_id, "IN_PROGRESS")
        world["invocation_id"] = invocation_id
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["error"] = exc
