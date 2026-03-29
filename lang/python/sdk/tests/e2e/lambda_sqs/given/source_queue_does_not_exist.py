"""Given: the source queue does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the source queue does not exist")
def source_queue_does_not_exist():
    """No-op: fresh state has no queues."""
