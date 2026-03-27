"""When: the caller fails to invoke the callee because the callee has been deleted"""

from __future__ import annotations

from pytest_bdd import when


@when("the caller fails to invoke the callee because the callee has been deleted")
def caller_invocation_fails_callee_deleted(lws_session, world):
    # Arrange
    invocation_id = world["invocation_id"]
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "FAILED")
