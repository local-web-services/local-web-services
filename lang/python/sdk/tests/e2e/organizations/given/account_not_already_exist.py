"""Given: the "organizations" "account" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "organizations" "account" did not already exist')
def account_not_already_exist():
    """No-op: org context is already established by the preceding organization step."""
