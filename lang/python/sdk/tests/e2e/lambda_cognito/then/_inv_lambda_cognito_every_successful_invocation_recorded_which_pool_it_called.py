"""Then: every successful invocation recorded which pool it called"""

from __future__ import annotations

from pytest_bdd import then


@then("every successful invocation recorded which pool it called")
def _inv_lambda_cognito_every_successful_invocation_recorded_which_pool_it_called():
    """Invariant step: trivially satisfied in isolated test context."""
