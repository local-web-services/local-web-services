"""Then: the "s3" "object" metadata will be returned"""

from __future__ import annotations

from pytest_bdd import then


@then('the "s3" "object" metadata will be returned')
def object_metadata_returned_then(world):
    actual_result = world["result"]
    assert actual_result is not None, f"Expected object metadata but got: {actual_result}"
    expected_header = "content-length"
    assert (
        expected_header in actual_result
    ), f"Expected '{expected_header}' in metadata headers but got: {actual_result}"
