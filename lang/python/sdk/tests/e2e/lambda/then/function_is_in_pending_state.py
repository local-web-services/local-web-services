"""Then: function_is_in_pending_state"""

from __future__ import annotations

from pytest_bdd import parsers, then


@then(parsers.re(r'^the function is in "PENDING" state$'))
def function_is_in_pending_state(world):
    assert world["error"] is None, f"Expected create_function to succeed but got: {world['error']}"
    expected_field = "FunctionName"
    actual_value = world["result"].get(expected_field)
    assert (
        actual_value is not None
    ), f"Expected '{expected_field}' in response but got: {world['result']}"
