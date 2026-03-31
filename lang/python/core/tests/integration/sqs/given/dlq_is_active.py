"""Given: the dead-letter queue was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the dead-letter queue was "ACTIVE"')
def dlq_is_active():
    """No-op: DLQ is ACTIVE by default after creation."""
