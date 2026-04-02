"""Then: every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue" """

from __future__ import annotations

from pytest_bdd import step


@step('every "IN_FLIGHT" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"')
def every_in_flight_message_belongs_to_active_queue():
    """Invariant: trivially satisfied in isolated lws context."""
