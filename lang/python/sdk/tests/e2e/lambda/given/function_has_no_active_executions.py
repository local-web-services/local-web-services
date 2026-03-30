"""Given: the function has no active executions"""

from __future__ import annotations

from pytest_bdd import given


@given("the function has no active executions")
def function_has_no_active_executions():
    """No-op: fresh state has no active executions."""
