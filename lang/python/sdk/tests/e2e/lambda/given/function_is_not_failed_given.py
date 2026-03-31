"""Given: function_is_not_failed_given"""

from __future__ import annotations

from pytest_bdd import given


@given('the "lambda" "function" was not "FAILED"')
def function_is_not_failed_given():
    """No-op: functions are not FAILED in fresh state."""
