"""When: the Lambda function fails to connect because the DocumentDB cluster is stopped"""

from __future__ import annotations

from pytest_bdd import when


@when("the Lambda function fails to connect because the DocumentDB cluster is stopped")
def invocation_fails_cluster_stopped(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id")
    if invocation_id is None:
        world["error"] = RuntimeError("No invocation is in progress")
        return
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "FAILED")
