"""Given: the "organizations" "organizational unit" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "organizations" "organizational unit" did not already exist')
def ou_not_already_exist():
    """No-op: fresh state has no OUs."""
