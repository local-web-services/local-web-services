"""Given: the dead-letter queue is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the dead-letter queue is "ACTIVE"')
def dlq_is_active():
    """No-op: DLQ is ACTIVE by default."""
