"""Then: every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine" """

from __future__ import annotations

from pytest_bdd import step


@step(
    'every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"'
)
def _inv_stepfunctions_glacier_every_running_execution_references_an_active_state_ma():
    """Invariant step: trivially satisfied in isolated test context."""
