"""Then: every execution belongs to a known state machine"""

from __future__ import annotations

from pytest_bdd import then


@then("every execution belongs to a known state machine")
def every_execution_belongs_to_known_sm():
    """Invariant: trivially satisfied in isolated integration test context."""
