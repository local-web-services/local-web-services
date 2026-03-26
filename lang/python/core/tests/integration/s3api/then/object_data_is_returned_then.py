"""Then: the object data is returned"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import INT_BODY


@then("the object data is returned")
def object_data_is_returned_then(world):
    actual_result = world["result"]
    expected_content = INT_BODY
    assert (
        actual_result == expected_content
    ), f"Expected object content '{expected_content}' but got: {actual_result}"
