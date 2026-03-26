"""Given: the target function is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the target function is "ACTIVE"')
def events_lambda_target_function_is_active():
    """No-op: Lambda functions are ACTIVE immediately after creation."""
