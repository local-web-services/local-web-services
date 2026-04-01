"""Given: the "organizations" "policy" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "organizations" "organization" did not already exist')
def org_not_already_exist():
    """No-op: fresh state has no organization."""
