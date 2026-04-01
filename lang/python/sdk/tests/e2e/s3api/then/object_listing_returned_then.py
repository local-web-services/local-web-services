"""Then: the object listing is returned"""

from __future__ import annotations

from pytest_bdd import then


@then("the object listing is returned")
def object_listing_returned_then(world):
    actual_result = world["result"]
    assert actual_result is not None, f"Expected object listing but got: {actual_result}"
