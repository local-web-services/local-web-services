"""Given: the subnet group does not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the subnet group does not already exist")
def sg_not_already_exist():
    """No-op: fresh state has no subnet groups."""
