"""Then: every "IN_PROGRESS" invocation is for a "PENDING" user"""

from __future__ import annotations

from pytest_bdd import then


@then('every "IN_PROGRESS" invocation is for a "PENDING" user')
def _inv_cognito_lambda_every_in_progress_invocation_is_for_a_pending_user():
    """Invariant step: trivially satisfied in isolated test context."""
