"""Given: the "lambda" "function" did not exist or was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "lambda" "function" did not exist or was "ACTIVE"')
def sm_lambda_function_not_exist_or_not_active():
    """No-op: fresh state has no functions."""
