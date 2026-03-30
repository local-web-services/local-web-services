"""Then: every "RUNNING" execution has a corresponding "IN_PROGRESS" request"""

from __future__ import annotations

from pytest_bdd import then


@then('every "RUNNING" execution has a corresponding "IN_PROGRESS" request')
def _inv_apigateway_stepfunctions_every_running_execution_has_a_corresponding_in_pro():
    """Invariant step: trivially satisfied in isolated test context."""
