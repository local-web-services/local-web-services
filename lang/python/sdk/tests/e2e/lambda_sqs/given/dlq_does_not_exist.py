"""Given: the dead-letter queue did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the dead-letter queue did not exist")
def dlq_does_not_exist():
    """No-op: fresh state has no queues."""
