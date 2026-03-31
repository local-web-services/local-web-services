"""Given: the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted"""

from __future__ import annotations

import uuid

from pytest_bdd import given


@given('the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted')
def lambda_function_failed_upload_vault_deleted_seq(lws_session, world):
    # Arrange
    invocation_id = str(uuid.uuid4())
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "FAILED")
    # Assert
    world["invocation_id"] = invocation_id
