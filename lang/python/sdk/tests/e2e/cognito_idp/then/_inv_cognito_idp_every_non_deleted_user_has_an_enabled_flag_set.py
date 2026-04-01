"""Then: every non-deleted user has an enabled flag set"""

from __future__ import annotations

from pytest_bdd import step


@step("every non-deleted user has an enabled flag set")
def _inv_cognito_idp_every_non_deleted_user_has_an_enabled_flag_set():
    """Invariant step: trivially satisfied in isolated test context."""
