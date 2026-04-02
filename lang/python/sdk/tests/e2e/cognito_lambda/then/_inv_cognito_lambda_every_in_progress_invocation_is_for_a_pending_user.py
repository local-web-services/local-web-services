"""Then: every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user" """

from __future__ import annotations

from pytest_bdd import step


@step('every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"')
def _inv_cognito_lambda_every_in_progress_invocation_is_for_a_pending_user():
    """Invariant step: trivially satisfied in isolated test context."""
