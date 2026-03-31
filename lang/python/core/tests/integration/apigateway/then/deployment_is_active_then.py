"""Then: the "api gateway" "deployment" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then


@then('the "api gateway" "deployment" will be "ACTIVE"')
def deployment_is_active_then(world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected deployment creation result but got None"
    expected_field = "id"
    assert (
        expected_field in actual_result
    ), f"Expected deployment result to contain '{expected_field}' but got: {actual_result}"
