"""Given: the source "sqs" "queue" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the source "sqs" "queue" did not exist')
def source_queue_does_not_exist():
    """No-op: fresh state has no queues."""
