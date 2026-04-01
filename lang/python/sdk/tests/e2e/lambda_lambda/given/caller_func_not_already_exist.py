"""Given: the caller "lambda" "function" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the caller "lambda" "function" did not already exist')
def caller_func_not_already_exist():
    """No-op: fresh state has no functions."""
