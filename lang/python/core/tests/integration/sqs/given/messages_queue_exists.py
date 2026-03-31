"""Given: the "sqs" "message"'s "sqs" "queue" existed"""

from __future__ import annotations

from pytest_bdd import given


@given('the "sqs" "message"\'s "sqs" "queue" existed')
def messages_queue_exists():
    """No-op: queue was created in 'the "sqs" "message" existed' step."""
