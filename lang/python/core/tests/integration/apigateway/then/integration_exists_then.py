"""Then: the integration "EXISTS" """

from __future__ import annotations

from pytest_bdd import then


@then('the integration "EXISTS"')
def integration_exists_then(world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected integration result but got None"
    expected_field = "type"
    assert (
        expected_field in actual_result
    ), f"Expected integration result to contain '{expected_field}' but got: {actual_result}"
