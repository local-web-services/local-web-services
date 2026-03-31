"""Given: function_is_not_pending_given"""

from __future__ import annotations

from pytest_bdd import given


@given('the "lambda" "function" was not "PENDING"')
def function_is_not_pending_given():
    """No-op: functions resolve past PENDING immediately in lws."""
