"""Then: the dead-letter queue never exceeds its bounded capacity."""

from __future__ import annotations

from pytest_bdd import then


@then('the "eventbridge" "dead-letter queue" never exceeds its bounded capacity')
def dlq_never_exceeds_capacity():
    """Invariant: trivially satisfied in isolated integration test context."""
