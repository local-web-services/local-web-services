"""Given: no "AVAILABLE" "sqs" "message" existed in the "sqs" "queue" """

from __future__ import annotations

from pytest_bdd import given


@given('no "AVAILABLE" message existed in the queue')
@given('no "AVAILABLE" "sqs" "message" existed in the "sqs" "queue"')
def no_available_message_exists():
    """No-op: fresh state has no messages."""
