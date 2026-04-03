"""When: the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds"""

from __future__ import annotations

from pytest_bdd import when


@when(
    'the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds'
)
def lambda_writes_document(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id")
    # Act
    if invocation_id is None:
        world["error"] = RuntimeError("No invocation is in progress")
        return
    lws_session.inject_state_unchecked("lambda", "invocation", invocation_id, "SUCCESS")
