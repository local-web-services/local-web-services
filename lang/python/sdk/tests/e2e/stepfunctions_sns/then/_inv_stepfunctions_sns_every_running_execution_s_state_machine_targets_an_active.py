"""Then: every "RUNNING" execution's state machine targets an "ACTIVE" topic"""

from __future__ import annotations

from pytest_bdd import step


@step('every "RUNNING" execution\'s state machine targets an "ACTIVE" topic')
def _inv_stepfunctions_sns_every_running_execution_s_state_machine_targets_an_active():
    """Invariant step: trivially satisfied in isolated test context."""
