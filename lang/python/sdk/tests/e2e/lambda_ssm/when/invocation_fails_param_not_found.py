"""When: the "lambda" "function" fails because the parameter has been deleted"""

from __future__ import annotations

from pytest_bdd import when


@when('the "lambda" "function" fails because the parameter has been deleted')
def invocation_fails_param_not_found(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id")
    if invocation_id is None:
        world["error"] = RuntimeError("No invocation is in progress")
        return
    if not world.get("param_deleted", True):
        world["error"] = RuntimeError("Parameter is not DELETED")
        return
    # Act
    lws_session.inject_state_unchecked("lambda", "invocation", invocation_id, "FAILED")
