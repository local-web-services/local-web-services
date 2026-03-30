"""Given: the target queue is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the target queue is "ACTIVE"')
def target_queue_is_active():
    """No-op: queues are ACTIVE by default after creation."""
