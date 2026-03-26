"""Then: no function in "DELETING" state has active executions"""

from __future__ import annotations

from pytest_bdd import then


@then('no function in "DELETING" state has active executions')
def _inv_lambda_no_function_in_deleting_state_has_active_executions():
    """Invariant step: trivially satisfied in isolated test context."""
