"""Then: the new resource is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then


@then('the new resource is "ACTIVE"')
def new_resource_is_active_then(world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected resource creation result but got None"
    expected_field = "id"
    assert (
        expected_field in actual_result
    ), f"Expected resource result to contain '{expected_field}' but got: {actual_result}"
