"""Then: the callee function is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_CALLEE


@then('the callee function is "ACTIVE"')
def callee_func_is_active_then(lws_session):
    resp = lws_session.client("lambda").get_function(FunctionName=TEST_CALLEE)
    expected_state = "Active"
    actual_state = resp["Configuration"]["State"]
    assert (
        actual_state == expected_state
    ), f"Expected callee function state '{expected_state}' but got '{actual_state}'"
