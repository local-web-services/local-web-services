"""Then: the root "api gateway" "resource" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then


@then('the root "api gateway" "resource" will be "ACTIVE"')
def root_resource_is_active_then(lws_session, world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected get_resources result but got None"
    assert world["error"] is None, f"Expected no error but got: {world['error']}"
    expected_field = "items"
    assert (
        expected_field in actual_result
    ), f"Expected '{expected_field}' in get_resources result but got: {actual_result}"
    actual_items = actual_result[expected_field]
    assert len(actual_items) >= 1, "Expected at least one resource (root) but found none"
