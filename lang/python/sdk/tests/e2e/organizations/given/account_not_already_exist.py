"""Given: the account does not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the account does not already exist")
def account_not_already_exist():
    """No-op: org context is already established by the preceding organization step."""
