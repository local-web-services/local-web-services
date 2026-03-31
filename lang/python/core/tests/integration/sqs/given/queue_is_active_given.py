"""Given: the "sqs" "queue" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "sqs" "queue" was "ACTIVE"')
@given('the "sqs" "queue" will be "ACTIVE"')
def queue_is_active_given():
    """No-op: queues are ACTIVE by default after creation."""
