"""Given: the caller has failed to invoke the callee because the callee has been deleted"""

from __future__ import annotations

import uuid

from pytest_bdd import given


@given("the caller has failed to invoke the callee because the callee has been deleted")
def caller_failed_to_invoke_callee_deleted_seq(lws_session, world):
    # Arrange
    invocation_id = str(uuid.uuid4())
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "FAILED")
    # Assert
    world["invocation_id"] = invocation_id
