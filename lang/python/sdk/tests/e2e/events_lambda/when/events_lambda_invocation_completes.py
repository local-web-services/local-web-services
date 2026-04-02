"""When: the "lambda" "function" invocation completes successfully"""

from __future__ import annotations

from pytest_bdd import when


@when('the "lambda" "function" invocation completes successfully')
def events_lambda_invocation_completes(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id")
    # Act
    if invocation_id is None:
        world["error"] = RuntimeError("No invocation is in progress")
        return
    lws_session.inject_state("lambda", "invocation", invocation_id, "SUCCESS")
