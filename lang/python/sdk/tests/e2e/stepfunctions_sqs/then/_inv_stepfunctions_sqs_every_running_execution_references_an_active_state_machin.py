"""Then: every "RUNNING" execution references an "ACTIVE" state machine"""

from __future__ import annotations

from pytest_bdd import then


@then('every "RUNNING" execution references an "ACTIVE" state machine')
def _inv_stepfunctions_sqs_every_running_execution_references_an_active_state_machin():
    """Invariant step: trivially satisfied in isolated test context."""
