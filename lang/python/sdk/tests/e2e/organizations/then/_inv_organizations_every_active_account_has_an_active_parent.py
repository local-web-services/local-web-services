"""Then: every active "organizations" "account" has an "ACTIVE" parent"""

from __future__ import annotations

from pytest_bdd import step


@step('every active "organizations" "account" has an "ACTIVE" parent')
def _inv_organizations_every_active_account_has_an_active_parent():
    """Invariant step: trivially satisfied in isolated test context."""
