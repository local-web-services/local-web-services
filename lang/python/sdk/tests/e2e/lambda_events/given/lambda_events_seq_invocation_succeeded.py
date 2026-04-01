"""Given: the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds"""

from __future__ import annotations

import uuid

from pytest_bdd import given


@given('the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds')
def lambda_events_seq_invocation_succeeded(lws_session, world):
    # Arrange
    invocation_id = str(uuid.uuid4())
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "SUCCESS")
    # Assert
    world["invocation_id"] = invocation_id
