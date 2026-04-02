"""Given: the target "lambda" "function" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the target "lambda" "function" was "ACTIVE"')
def events_lambda_target_function_is_active():
    """No-op: Lambda functions are ACTIVE immediately after creation."""
