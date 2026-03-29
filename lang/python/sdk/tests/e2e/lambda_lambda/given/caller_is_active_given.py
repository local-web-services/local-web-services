"""Given: the caller is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the caller is "ACTIVE"')
def caller_is_active_given():
    """No-op: functions are ACTIVE immediately after creation."""
