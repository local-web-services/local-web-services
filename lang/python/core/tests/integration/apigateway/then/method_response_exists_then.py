"""Then: the "api gateway" "method" response will exist"""

from __future__ import annotations

from pytest_bdd import then


@then('the "api gateway" "method" response will exist')
def method_response_exists_then(world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected method response result but got None"
    expected_field = "statusCode"
    assert (
        expected_field in actual_result
    ), f"Expected method response result to contain '{expected_field}' but got: {actual_result}"
