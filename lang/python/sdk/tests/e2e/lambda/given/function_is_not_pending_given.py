"""Given: function_is_not_pending_given"""

from __future__ import annotations

from pytest_bdd import given, parsers


@given(parsers.re(r'^the function is not "PENDING"$'))
def function_is_not_pending_given():
    """No-op: functions resolve past PENDING immediately in lws."""
