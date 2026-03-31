"""When: the "lambda" "function" reads an existing parameter and completes successfully"""

from __future__ import annotations

from pytest_bdd import when


@when('the "lambda" "function" reads an existing parameter and completes successfully')
def invocation_reads_param_succeeds(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id")
    if invocation_id is None:
        world["error"] = RuntimeError("No invocation is in progress")
        return
    if world.get("param_deleted", True):
        world["error"] = RuntimeError("Parameter does not exist or is DELETED")
        return
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "SUCCESS")
