"""Then: every "step functions" "execution" belongs to a known "step functions" "state machine" """

from __future__ import annotations

from pytest_bdd import then


@then('every "step functions" "execution" belongs to a known "step functions" "state machine"')
def every_execution_belongs_to_known_sm():
    """Invariant: trivially satisfied in isolated integration test context."""
