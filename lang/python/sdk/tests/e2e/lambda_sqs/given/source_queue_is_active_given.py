"""Given: the source "sqs" "queue" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the source "sqs" "queue" was "ACTIVE"')
def source_queue_is_active_given():
    """No-op: queues are ACTIVE immediately after creation."""
