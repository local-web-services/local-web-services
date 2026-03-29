"""Given: the Lambda function has failed to publish because the event bus has been deleted"""

from __future__ import annotations

import uuid

from pytest_bdd import given


@given("the Lambda function has failed to publish because the event bus has been deleted")
def lambda_events_seq_invocation_failed(lws_session, world):
    # Arrange
    invocation_id = str(uuid.uuid4())
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "FAILED")
    # Assert
    world["invocation_id"] = invocation_id
