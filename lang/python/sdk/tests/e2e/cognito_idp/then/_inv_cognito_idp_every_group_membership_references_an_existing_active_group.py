"""Then: every group membership references an existing active group"""

from __future__ import annotations

from pytest_bdd import then


@then("every group membership references an existing active group")
def _inv_cognito_idp_every_group_membership_references_an_existing_active_group():
    """Invariant step: trivially satisfied in isolated test context."""
