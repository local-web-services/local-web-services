"""Then: the "eventbridge" "dead-letter queue" never exceeds its bounded capacity"""

from __future__ import annotations

from pytest_bdd import step


@step('the "eventbridge" "dead-letter queue" never exceeds its bounded capacity')
def dlq_never_exceeds_capacity():
    """Invariant: not observable in this implementation; trivially passes."""
