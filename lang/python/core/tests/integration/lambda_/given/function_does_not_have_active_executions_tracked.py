"""Given: the "lambda" "function" does not have active executions tracked"""

from __future__ import annotations

from pytest_bdd import given


@given('the "lambda" "function" does not have active executions tracked')
def function_does_not_have_active_executions_tracked():
    """No-op: fresh functions have no tracked executions."""
