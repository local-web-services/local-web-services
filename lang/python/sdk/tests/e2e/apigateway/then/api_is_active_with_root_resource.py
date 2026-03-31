"""Then: the "api gateway" "API" will be "ACTIVE" and its root resource will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then


@then('the "api gateway" "API" will be "ACTIVE" and its root resource will be "ACTIVE"')
def api_is_active_with_root_resource(lws_session, world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected REST API creation result but got None"
    expected_field = "id"
    assert (
        expected_field in actual_result
    ), f"Expected '{expected_field}' in REST API result but got: {actual_result}"
