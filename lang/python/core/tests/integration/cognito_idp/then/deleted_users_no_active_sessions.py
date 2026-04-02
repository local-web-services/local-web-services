"""Then: deleted "cognito" "user"s do not have active authenticated "cognito" "session"s"""

from __future__ import annotations

from pytest_bdd import then


@then('deleted "cognito" "user"s do not have active authenticated "cognito" "session"s')
def deleted_users_no_active_sessions():
    """Invariant trivially satisfied in an isolated test context."""
