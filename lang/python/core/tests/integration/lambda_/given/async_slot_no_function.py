"""Given: the async slot does not have a "lambda" "function" assigned"""

from __future__ import annotations

from pytest_bdd import given


@given('the async slot does not have a "lambda" "function" assigned')
def async_slot_no_function():
    """No-op: empty async slots have no function assigned."""
