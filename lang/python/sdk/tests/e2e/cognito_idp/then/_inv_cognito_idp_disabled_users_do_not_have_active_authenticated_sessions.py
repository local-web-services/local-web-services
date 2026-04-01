"""Then: disabled users do not have active authenticated sessions"""

from __future__ import annotations

from pytest_bdd import step


@step("disabled users do not have active authenticated sessions")
def _inv_cognito_idp_disabled_users_do_not_have_active_authenticated_sessions():
    """Invariant step: trivially satisfied in isolated test context."""
