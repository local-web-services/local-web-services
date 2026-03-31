"""Then: function_enters_deleting_state"""

from __future__ import annotations

from pytest_bdd import then


@then('the "lambda" "function" will be in "DELETING" state')
def function_enters_deleting_state(world):
    assert world["error"] is None, f"Expected delete_function to succeed but got: {world['error']}"
