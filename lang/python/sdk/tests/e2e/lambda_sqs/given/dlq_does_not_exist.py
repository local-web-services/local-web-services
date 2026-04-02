"""Given: the dead-letter "sqs" "queue" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the dead-letter "sqs" "queue" did not exist')
def dlq_does_not_exist():
    """No-op: fresh state has no queues."""
