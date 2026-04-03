"""When: the "lambda" "function" invocation fails"""

from __future__ import annotations

from pytest_bdd import when


@when('the "lambda" "function" invocation fails')
def events_lambda_invocation_fails(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id")
    # Act
    if invocation_id is None:
        world["error"] = RuntimeError("No invocation is in progress")
        return
    lws_session.inject_state_unchecked("lambda", "invocation", invocation_id, "FAILED")
