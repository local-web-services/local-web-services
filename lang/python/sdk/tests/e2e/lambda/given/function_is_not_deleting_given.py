"""Given: function_is_not_deleting_given"""

from __future__ import annotations

from pytest_bdd import given, parsers


@given(parsers.re(r'^the function is not "DELETING"$'))
def function_is_not_deleting_given():
    """No-op: functions are not in DELETING state in fresh state."""
