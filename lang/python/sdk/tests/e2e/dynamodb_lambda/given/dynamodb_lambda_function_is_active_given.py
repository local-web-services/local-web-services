"""Given: the mapped function was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "lambda" "function" was "ACTIVE"')
def dynamodb_lambda_function_is_active_given():
    """No-op: Lambda functions are ACTIVE immediately after creation."""
