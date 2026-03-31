"""Then: the "api gateway" "method" response will exist"""

from __future__ import annotations

from pytest_bdd import then


@then('the "api gateway" "method" response will exist')
def method_response_exists_then(lws_session, world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected put_method_response result but got None"
    expected_field = "statusCode"
    assert (
        expected_field in actual_result
    ), f"Expected '{expected_field}' in method response result but got: {actual_result}"
