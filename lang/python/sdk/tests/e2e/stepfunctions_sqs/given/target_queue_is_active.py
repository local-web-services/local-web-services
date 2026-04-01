"""Given: the target queue was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the target queue was "ACTIVE"')
def target_queue_is_active():
    """No-op: queues are ACTIVE by default after creation."""
