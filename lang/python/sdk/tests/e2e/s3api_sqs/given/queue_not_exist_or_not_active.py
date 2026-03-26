"""Given: the queue does not exist or is not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the queue does not exist or is not "ACTIVE"')
def queue_not_exist_or_not_active():
    """No-op: fresh state has no queues, so the queue does not exist."""
