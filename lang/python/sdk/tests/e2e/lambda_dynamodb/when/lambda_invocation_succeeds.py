"""When: the "lambda" "function" invocation completes successfully"""

from __future__ import annotations

from pytest_bdd import when


@when('the "lambda" "function" invocation completes successfully')
def lambda_invocation_succeeds(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id")
    # Act
    if invocation_id is None:
        world["error"] = RuntimeError("No invocation is in progress")
        return
    lws_session.inject_state_unchecked("lambda", "invocation", invocation_id, "SUCCESS")
