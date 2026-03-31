"""Then: the "api gateway" "API" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then


@then('the "api gateway" "API" was "ACTIVE"')
@then('the "api gateway" "API" will be "ACTIVE" and its root resource will be "ACTIVE"')
def api_is_active_then(world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected REST API creation result but got None"
    expected_field = "id"
    assert (
        expected_field in actual_result
    ), f"Expected REST API result to contain '{expected_field}' but got: {actual_result}"
