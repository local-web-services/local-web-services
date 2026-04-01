"""Given: the "lambda" "function" was "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the "lambda" "function" was "DELETED"')
def function_is_not_deleted():
    """No-op: functions are not in DELETED state by default."""
