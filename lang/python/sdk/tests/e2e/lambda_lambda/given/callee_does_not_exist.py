"""Given: the callee does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the callee does not exist")
def callee_does_not_exist():
    """No-op: fresh state has no functions."""
