"""Then: the integration response exists"""

from __future__ import annotations

from pytest_bdd import then


@then("the integration response exists")
def integration_response_exists_then(world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected integration response result but got None"
    expected_field = "statusCode"
    assert expected_field in actual_result, (
        f"Expected integration response result to contain "
        f"'{expected_field}' but got: {actual_result}"
    )
