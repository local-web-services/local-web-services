"""
Given: an event has been published to the bus and has triggered an asynchronous Lambda invocation
"""

from __future__ import annotations

import uuid

from pytest_bdd import given


@given(
    'an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation'
)
def events_lambda_seq_event_published_and_invoked(lws_session, world):
    # Arrange
    invocation_id = str(uuid.uuid4())
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "IN_PROGRESS")
    # Assert
    world["invocation_id"] = invocation_id
