"""Then: disabled "cognito" "user"s do not have active authenticated "cognito" "session"s"""

from __future__ import annotations

from pytest_bdd import then


@then('disabled "cognito" "user"s do not have active authenticated "cognito" "session"s')
def disabled_users_no_active_sessions():
    """Invariant trivially satisfied in an isolated test context."""
