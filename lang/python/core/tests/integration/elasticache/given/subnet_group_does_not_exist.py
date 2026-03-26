"""Given: the subnet group does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the subnet group does not exist")
def subnet_group_does_not_exist():
    """No-op: fresh state has no subnet groups."""
