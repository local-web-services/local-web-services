"""Then: the "lambda" "function" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_FUNC


@then('the "lambda" "function" will be "ACTIVE"')
def lambda_s3tables_function_is_active_then(lws_session):
    resp = lws_session.client("lambda").get_function(FunctionName=TEST_FUNC)
    expected_state = "Active"
    actual_state = resp["Configuration"].get("State", "")
    assert (
        actual_state == expected_state
    ), f"Expected function state '{expected_state}' but got '{actual_state}'"
