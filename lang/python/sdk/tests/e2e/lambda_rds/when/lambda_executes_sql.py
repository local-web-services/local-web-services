"""When: the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds"""

from __future__ import annotations

from pytest_bdd import when


@when(
    'the "lambda" "function" executes a "SQL" query against the "AVAILABLE" database and succeeds'
)
def lambda_executes_sql(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id")
    # Act
    if invocation_id is None:
        world["error"] = RuntimeError("No invocation is in progress")
        return
    lws_session.inject_state("lambda", "invocation", invocation_id, "SUCCESS")
