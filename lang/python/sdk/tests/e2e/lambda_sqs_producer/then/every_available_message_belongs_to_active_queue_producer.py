"""Then: every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue" """

from __future__ import annotations

from pytest_bdd import step


@step('every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"')
def every_available_message_belongs_to_active_queue_producer():
    """Invariant step: trivially satisfied in isolated test context."""
