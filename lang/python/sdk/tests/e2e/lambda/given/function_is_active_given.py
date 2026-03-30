"""Given: function_is_active_given"""

from __future__ import annotations

from pytest_bdd import given, parsers


@given(parsers.re(r'^the function is "ACTIVE"$'))
def function_is_active_given():
    """No-op: lws resolves functions to ACTIVE immediately."""
