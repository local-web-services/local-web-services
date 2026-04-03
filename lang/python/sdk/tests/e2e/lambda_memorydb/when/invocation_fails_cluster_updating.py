"""When: the "lambda" "function" fails to write because the "memorydb" "cluster" is updating"""

from __future__ import annotations

from pytest_bdd import when


@when('the "lambda" "function" fails to write because the "memorydb" "cluster" is updating')
def invocation_fails_cluster_updating(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id")
    if invocation_id is None:
        world["error"] = RuntimeError("No invocation is in progress")
        return
    # Act
    lws_session.inject_state_unchecked("lambda", "invocation", invocation_id, "FAILED")
