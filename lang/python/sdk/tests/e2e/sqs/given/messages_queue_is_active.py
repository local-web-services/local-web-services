"""Given: the message's sqs queue was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "sqs" "message"\'s "sqs" "queue" was "ACTIVE"')
def messages_queue_is_active():
    """No-op: queue is ACTIVE by default."""
