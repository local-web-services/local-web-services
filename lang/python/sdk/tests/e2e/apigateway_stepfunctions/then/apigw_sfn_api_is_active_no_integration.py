"""Then: the "API" is "ACTIVE" with no Step Functions integration configured"""

from __future__ import annotations

from pytest_bdd import then

from ..client import ApigatewayStepfunctionsTestClient
from ..constants import TEST_API


@then('the "API" is "ACTIVE" with no Step Functions integration configured')
def apigw_sfn_api_is_active_no_integration(lws_session):
    api_id = ApigatewayStepfunctionsTestClient(lws_session).get_api_id()
    assert api_id is not None, f"Expected REST API '{TEST_API}' to exist but it was not found"
    resp = lws_session.client("apigateway").get_rest_api(restApiId=api_id)
    actual_name = resp.get("name", "")
    expected_name = TEST_API
    assert (
        actual_name == expected_name
    ), f"Expected API name '{expected_name}' but got '{actual_name}'"
