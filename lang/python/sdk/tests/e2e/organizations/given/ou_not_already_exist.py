"""Given: the organizational unit does not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the organizational unit does not already exist")
def ou_not_already_exist():
    """No-op: fresh state has no OUs."""
