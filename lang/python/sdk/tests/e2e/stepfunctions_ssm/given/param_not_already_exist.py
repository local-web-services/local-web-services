"""Given: the parameter does not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the parameter does not already exist")
def param_not_already_exist():
    """No-op: fresh state has no parameters."""
