"""Then: the caller "lambda" "function" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_CALLER


@then('the caller "lambda" "function" will be "ACTIVE"')
def caller_func_is_active_then(lws_session):
    resp = lws_session.client("lambda").get_function(FunctionName=TEST_CALLER)
    expected_state = "Active"
    actual_state = resp["Configuration"]["State"]
    assert (
        actual_state == expected_state
    ), f"Expected caller function state '{expected_state}' but got '{actual_state}'"
