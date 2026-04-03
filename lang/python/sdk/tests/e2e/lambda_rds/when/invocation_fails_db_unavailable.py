"""When: the "lambda" "function" fails to connect because the database is failing over"""

from __future__ import annotations

from pytest_bdd import when


@when('the "lambda" "function" fails to connect because the database is failing over')
def invocation_fails_db_unavailable(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id")
    if invocation_id is None:
        world["error"] = RuntimeError("No invocation is in progress")
        return
    # Act
    lws_session.inject_state_unchecked("lambda", "invocation", invocation_id, "FAILED")
