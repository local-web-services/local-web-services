"""Given: the function does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the function does not exist")
def cognito_lambda_function_does_not_exist():
    """No-op: fresh state has no Lambda functions."""
