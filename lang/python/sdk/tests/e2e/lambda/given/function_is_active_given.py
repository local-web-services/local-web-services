"""Given: function_is_active_given"""

from __future__ import annotations

from pytest_bdd import given


@given('the "lambda" "function" was "ACTIVE"')
def function_is_active_given():
    """No-op: lws resolves functions to ACTIVE immediately."""
