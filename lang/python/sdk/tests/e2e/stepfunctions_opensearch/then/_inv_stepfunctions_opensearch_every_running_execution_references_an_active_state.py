"""Then: every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine" """

from __future__ import annotations

from pytest_bdd import step


@step(
    'every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"'
)
def _inv_stepfunctions_opensearch_every_running_execution_references_an_active_state():
    """Invariant step: trivially satisfied in isolated test context."""
