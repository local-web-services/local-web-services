"""Given: the function is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the function is "ACTIVE"')
def function_is_active():
    """No-op: functions are ACTIVE immediately after creation in lws."""
