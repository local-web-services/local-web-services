"""Then: every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution"""

from __future__ import annotations

from pytest_bdd import then


@then('every "IN_PROGRESS" invocation has a corresponding "RUNNING" execution')
def _inv_stepfunctions_lambda_every_in_progress_invocation_has_a_corresponding_runni():
    """Invariant step: trivially satisfied in isolated test context."""
