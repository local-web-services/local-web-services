"""Given: the message's queue is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the message\'s queue is "ACTIVE"')
def messages_queue_is_active():
    """No-op: queue is ACTIVE by default."""
