"""Given: the parameter does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the parameter does not exist")
def param_does_not_exist():
    """No-op: fresh state has no parameters."""
