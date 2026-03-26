"""Given: the parameter group does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the parameter group does not exist")
def pg_does_not_exist():
    """No-op: fresh state has no parameter groups."""
