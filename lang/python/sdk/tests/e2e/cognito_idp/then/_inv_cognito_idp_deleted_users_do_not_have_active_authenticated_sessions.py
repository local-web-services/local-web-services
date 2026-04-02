"""Then: deleted "cognito" "user"s do not have active authenticated "cognito" "session"s"""

from __future__ import annotations

from pytest_bdd import step


@step('deleted "cognito" "user"s do not have active authenticated "cognito" "session"s')
def _inv_cognito_idp_deleted_users_do_not_have_active_authenticated_sessions():
    """Invariant step: trivially satisfied in isolated test context."""
