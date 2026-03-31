"""Given: the "organizations" "organization" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "organizations" "organization" did not exist')
def org_does_not_exist():
    """No-op: fresh state has no organization."""
