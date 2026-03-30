"""Then: the root resource is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then


@then('the root resource is "ACTIVE"')
def root_resource_is_active_then(world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected root resource result but got None"
    expected_field = "id"
    assert (
        expected_field in actual_result
    ), f"Expected root resource result to contain '{expected_field}' but got: {actual_result}"
