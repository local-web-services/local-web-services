"""Given: the "sqs" "queue" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "sqs" "queue" did not already exist')
def queue_not_already_exist():
    """No-op: fresh provider state has no queue named TEST_QUEUE."""
