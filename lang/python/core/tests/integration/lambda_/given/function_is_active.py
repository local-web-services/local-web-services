"""Given: the "lambda" "function" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "lambda" "function" was "ACTIVE"')
@given('the "lambda" "function" will be "ACTIVE"')
def function_is_active():
    """No-op: functions are ACTIVE immediately after creation in lws."""
