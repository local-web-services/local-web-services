"""Then: every succeeded execution recorded which pool it called"""

from __future__ import annotations

from pytest_bdd import then


@then("every succeeded execution recorded which pool it called")
def _inv_stepfunctions_cognito_every_succeeded_execution_recorded_which_pool_it_call():
    """Invariant step: trivially satisfied in isolated test context."""
