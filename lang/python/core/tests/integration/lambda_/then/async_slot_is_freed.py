"""Then: the async slot is freed"""

from __future__ import annotations

from pytest_bdd import then


@then("the async slot is freed")
def async_slot_is_freed(world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected async slot to be freed but got: {actual_error}"
