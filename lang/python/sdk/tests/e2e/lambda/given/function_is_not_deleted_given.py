"""Given: function_is_not_deleted_given"""

from __future__ import annotations

from pytest_bdd import given, parsers


@given(parsers.re(r'^the function is not "DELETED"$'))
def function_is_not_deleted_given():
    """No-op: functions are not DELETED in fresh state."""
