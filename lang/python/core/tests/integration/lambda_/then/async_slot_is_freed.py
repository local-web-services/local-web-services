"""Then: the "lambda" "async" "slot" will be freed"""

from __future__ import annotations

from pytest_bdd import then


@then('the "lambda" "async" "slot" will be freed')
def async_slot_is_freed(world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected async slot to be freed but got: {actual_error}"
