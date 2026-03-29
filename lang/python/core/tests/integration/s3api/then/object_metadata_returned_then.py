"""Then: the object metadata is returned"""

from __future__ import annotations

from pytest_bdd import then


@then("the object metadata is returned")
def object_metadata_returned_then(world):
    actual_result = world["result"]
    assert actual_result is not None, f"Expected object metadata but got: {actual_result}"
    expected_header = "content-length"
    assert (
        expected_header in actual_result
    ), f"Expected '{expected_header}' in metadata headers but got: {actual_result}"
