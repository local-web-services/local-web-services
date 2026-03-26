"""Given: the execution does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the execution does not exist")
def execution_does_not_exist():
    """No-op: fresh state has no executions."""
