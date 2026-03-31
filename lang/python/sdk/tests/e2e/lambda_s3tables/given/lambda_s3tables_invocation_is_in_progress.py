"""Given: a "lambda" "invocation" was "IN_PROGRESS" """

from __future__ import annotations

import uuid

from pytest_bdd import given


@given('a "lambda" "invocation" was "IN_PROGRESS"')
def lambda_s3tables_invocation_is_in_progress(lws_session, world):
    # Arrange
    invocation_id = str(uuid.uuid4())
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "IN_PROGRESS")
    # Assert
    world["invocation_id"] = invocation_id
