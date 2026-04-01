"""Given: the "lambda" "function" had no active executions"""

from __future__ import annotations

from pytest_bdd import given


@given('the "lambda" "function" had no active executions')
def function_has_no_active_executions():
    """No-op: fresh functions have no active executions."""
