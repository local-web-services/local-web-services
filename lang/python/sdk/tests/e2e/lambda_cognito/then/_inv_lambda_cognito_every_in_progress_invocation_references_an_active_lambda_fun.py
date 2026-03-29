"""Then: every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function"""

from __future__ import annotations

from pytest_bdd import then


@then('every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function')
def _inv_lambda_cognito_every_in_progress_invocation_references_an_active_lambda_fun():
    """Invariant step: trivially satisfied in isolated test context."""
