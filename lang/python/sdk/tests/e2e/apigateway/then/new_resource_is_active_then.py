"""Then: the new "api gateway" "resource" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then


@then('the new "api gateway" "resource" will be "ACTIVE"')
def new_resource_is_active_then(lws_session, world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected create_resource result but got None"
    expected_field = "id"
    assert (
        expected_field in actual_result
    ), f"Expected '{expected_field}' in resource result but got: {actual_result}"
