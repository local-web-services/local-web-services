"""Then: the "API" is "ACTIVE" with no Cognito authorizer configured"""

from __future__ import annotations

from pytest_bdd import then

from ..client import ApigatewayCognitoTestClient
from ..constants import TEST_API


@then('the "API" is "ACTIVE" with no Cognito authorizer configured')
def api_is_active_no_cognito_authorizer(lws_session):
    api_id = ApigatewayCognitoTestClient(lws_session).get_api_id()
    expected_api_id = api_id
    assert (
        expected_api_id is not None
    ), f"Expected REST API '{TEST_API}' to exist but it was not found"
    resp = ApigatewayCognitoTestClient(lws_session)._apigateway.get_rest_api(restApiId=api_id)
    actual_name = resp.get("name", "")
    expected_name = TEST_API
    assert (
        actual_name == expected_name
    ), f"Expected API name '{expected_name}' but got '{actual_name}'"
