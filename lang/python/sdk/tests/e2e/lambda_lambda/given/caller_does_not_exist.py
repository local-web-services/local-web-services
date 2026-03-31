"""Given: the caller "lambda" "function" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the caller "lambda" "function" did not exist')
def caller_does_not_exist():
    """No-op: fresh state has no functions."""
