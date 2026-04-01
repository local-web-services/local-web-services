"""Then: the "api gateway" "deployment" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then


@then('the "api gateway" "deployment" will be "ACTIVE"')
def deployment_is_active_then(lws_session, world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected deployment creation result but got None"
    expected_field = "id"
    assert (
        expected_field in actual_result
    ), f"Expected '{expected_field}' in deployment result but got: {actual_result}"
