"""Given: the "organizations" "account" did not exist or was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "organizations" "account" did not exist or was "ACTIVE"')
def account_does_not_exist_or_not_active(world):
    """Use a nonexistent account ID for negative scenarios."""
    world["account_id"] = "nonexistent-account-id"
    world["source_parent_id"] = "nonexistent-parent"
    world["dest_parent_id"] = "nonexistent-dest"
