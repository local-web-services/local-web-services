"""Then: the "api gateway" "integration" will exist"""

from __future__ import annotations

from pytest_bdd import then


@then('the "api gateway" "integration" will exist')
def integration_exists_then(lws_session, world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected put_integration result but got None"
    expected_field = "httpMethod"
    assert (
        expected_field in actual_result
    ), f"Expected '{expected_field}' in integration result but got: {actual_result}"
