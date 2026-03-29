"""Given: function_is_not_failed_given"""

from __future__ import annotations

from pytest_bdd import given, parsers


@given(parsers.re(r'^the function is not "FAILED"$'))
def function_is_not_failed_given():
    """No-op: functions are not FAILED in fresh state."""
