"""Then: the list of objects in the "s3" "bucket" will be returned"""

from __future__ import annotations

from pytest_bdd import then


@then('the list of objects in the "s3" "bucket" will be returned')
def list_of_objects_returned_then(world):
    actual_result = world["result"]
    assert actual_result is not None, f"Expected object listing but got: {actual_result}"
