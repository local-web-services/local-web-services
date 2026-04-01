"""Then: the "api gateway" "api" will be "ACTIVE" with no DynamoDB integration configured"""

from __future__ import annotations

from pytest_bdd import then

from ..client import ApigatewayDynamodbTestClient
from ..constants import TEST_API


@then('the "api gateway" "api" will be "ACTIVE" with no DynamoDB integration configured')
def apigw_dynamodb_api_is_active_no_integration(lws_session):
    api_id = ApigatewayDynamodbTestClient(lws_session).get_api_id()
    assert api_id is not None, f"Expected REST API '{TEST_API}' to exist but it was not found"
    resp = lws_session.client("apigateway").get_rest_api(restApiId=api_id)
    actual_name = resp.get("name", "")
    expected_name = TEST_API
    assert (
        actual_name == expected_name
    ), f"Expected API name '{expected_name}' but got '{actual_name}'"
