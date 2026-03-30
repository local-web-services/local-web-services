"""Then: the REST API is retrieved"""

from __future__ import annotations

from pytest_bdd import then


@then("the REST API is retrieved")
def rest_api_is_retrieved_then(world):
    expected_field = "id"
    actual_result = world["result"]
    assert (
        actual_result is not None and expected_field in actual_result
    ), f"Expected REST API retrieval result with 'id' key but got: {actual_result}"
