"""When: the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_CALLEE


@when('the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds')
def caller_invokes_callee_succeeds(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id")
    if invocation_id is None:
        world["error"] = RuntimeError("No invocation is in progress")
        return
    try:
        resp = lws_session.client("lambda").get_function(FunctionName=TEST_CALLEE)
        callee_state = resp.get("Configuration", {}).get("State", "")
        if callee_state != "Active":
            raise RuntimeError(f"Callee is not Active: {callee_state!r}")
    except (ClientError, RuntimeError) as exc:
        world["error"] = exc
        return
    # Act
    lws_session.inject_state_unchecked("lambda", "invocation", invocation_id, "SUCCESS")
