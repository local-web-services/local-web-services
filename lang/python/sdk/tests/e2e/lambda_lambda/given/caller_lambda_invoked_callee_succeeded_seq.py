"""Given: the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds"""

from __future__ import annotations

import uuid

from pytest_bdd import given


@given('the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds')
def caller_lambda_invoked_callee_succeeded_seq(lws_session, world):
    # Arrange
    invocation_id = str(uuid.uuid4())
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "SUCCESS")
    # Assert
    world["invocation_id"] = invocation_id
