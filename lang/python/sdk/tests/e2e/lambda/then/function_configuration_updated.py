"""Then: the function configuration is updated while remaining "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_FUNC


@then('the function configuration is updated while remaining "ACTIVE"')
def function_configuration_updated(lws_session, world):
    assert (
        world["error"] is None
    ), f"Expected update_function_configuration to succeed but got: {world['error']}"
    resp = lws_session.client("lambda").get_function(FunctionName=TEST_FUNC)
    actual_state = resp["Configuration"].get("State", "")
    expected_state = "Active"
    assert (
        actual_state == expected_state
    ), f"Expected function state '{expected_state}' but got '{actual_state}'"
