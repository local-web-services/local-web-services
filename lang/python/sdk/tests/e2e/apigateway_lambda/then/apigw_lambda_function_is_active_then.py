"""Then: the function is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..client import ApigatewayLambdaTestClient
from ..constants import TEST_FUNC


@then('the function is "ACTIVE"')
def apigw_lambda_function_is_active_then(lws_session):
    resp = ApigatewayLambdaTestClient(lws_session)._lambda.get_function(FunctionName=TEST_FUNC)
    expected_state = "Active"
    actual_state = resp["Configuration"].get("State", "")
    assert (
        actual_state == expected_state
    ), f"Expected function state '{expected_state}' but got '{actual_state}'"
