"""Given: the function is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the function is "ACTIVE"')
def func_is_active_given():
    """No-op: functions are ACTIVE immediately after creation."""
