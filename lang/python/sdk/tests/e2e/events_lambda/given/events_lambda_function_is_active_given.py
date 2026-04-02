"""Given: the target "lambda" "function" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "lambda" "function" was "ACTIVE"')
def events_lambda_function_is_active_given():
    """No-op: Lambda functions are ACTIVE immediately after creation."""
