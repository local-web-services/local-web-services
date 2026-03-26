"""Then: the method "EXISTS" on the resource"""

from __future__ import annotations

from pytest_bdd import then


@then('the method "EXISTS" on the resource')
def method_exists_on_resource_then(world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected method creation result but got None"
    expected_field = "httpMethod"
    assert (
        expected_field in actual_result
    ), f"Expected method result to contain '{expected_field}' but got: {actual_result}"
