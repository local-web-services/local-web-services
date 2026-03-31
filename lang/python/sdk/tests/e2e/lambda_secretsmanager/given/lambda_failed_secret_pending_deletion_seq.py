"""Given: the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion"""

from __future__ import annotations

import uuid

from pytest_bdd import given


@given('the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion')
def lambda_failed_secret_pending_deletion_seq(lws_session, world):
    # Arrange
    invocation_id = str(uuid.uuid4())
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "FAILED")
    # Assert
    world["invocation_id"] = invocation_id
