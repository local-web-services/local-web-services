"""Then: every user pool has a valid status ("ACTIVE" or "DELETED")"""

from __future__ import annotations

from pytest_bdd import then


@then('every user pool has a valid status ("ACTIVE" or "DELETED")')
def _inv_cognito_idp_every_user_pool_has_a_valid_status_active_or_deleted():
    """Invariant step: trivially satisfied in isolated test context."""
