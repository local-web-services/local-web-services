"""Given: the Lambda invocation completes successfully"""

from __future__ import annotations

import uuid

from pytest_bdd import given


@given("the Lambda invocation completes successfully")
def events_lambda_seq_invocation_completed(lws_session, world):
    # Arrange
    invocation_id = str(uuid.uuid4())
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "SUCCESS")
    # Assert
    world["invocation_id"] = invocation_id
