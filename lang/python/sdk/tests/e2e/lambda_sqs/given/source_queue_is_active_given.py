"""Given: the source queue was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the source queue was "ACTIVE"')
def source_queue_is_active_given():
    """No-op: queues are ACTIVE immediately after creation."""
