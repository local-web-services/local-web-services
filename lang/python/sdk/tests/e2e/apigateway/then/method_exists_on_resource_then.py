"""Then: the "api gateway" "method" will exist on the "api gateway" "resource" """

from __future__ import annotations

from pytest_bdd import then


@then('the "api gateway" "method" will exist on the "api gateway" "resource"')
def method_exists_on_resource_then(lws_session, world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected put_method result but got None"
    expected_field = "httpMethod"
    assert (
        expected_field in actual_result
    ), f"Expected '{expected_field}' in method result but got: {actual_result}"
