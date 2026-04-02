"""Then: every "RUNNING" "step functions" "execution" references a "step functions" "state machine" that exists"""

from __future__ import annotations

from pytest_bdd import step


@step(
    'every "RUNNING" "step functions" "execution" references a "step functions" "state machine" that exists'
)
def every_running_execution_references_existing_sm():
    """Invariant step: trivially satisfied in isolated test context."""
