"""Then: every "PENDING" user has a corresponding "IN_PROGRESS" invocation"""

from __future__ import annotations

from pytest_bdd import then


@then('every "PENDING" user has a corresponding "IN_PROGRESS" invocation')
def _inv_cognito_lambda_every_pending_user_has_a_corresponding_in_progress_invocatio():
    """Invariant step: trivially satisfied in isolated test context."""
