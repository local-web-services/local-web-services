"""Given: the subscribed queue is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the subscribed queue is "ACTIVE"')
def subscribed_queue_is_active():
    """No-op: queues are ACTIVE by default after creation."""
