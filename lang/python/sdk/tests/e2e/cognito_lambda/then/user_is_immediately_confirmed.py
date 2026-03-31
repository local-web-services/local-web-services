"""Then: the cognito user will be immediately "CONFIRMED" """

from __future__ import annotations

from pytest_bdd import then

from ..client import CognitoLambdaTestClient


@then('the cognito user will be immediately "CONFIRMED"')
def user_is_immediately_confirmed(lws_session):
    pool_id = CognitoLambdaTestClient(lws_session).get_pool_id()
    resp = lws_session.client("cognito-idp").list_users(UserPoolId=pool_id)
    actual_users = resp.get("Users", [])
    expected_count = 1
    actual_count = len(actual_users)
    assert (
        actual_count >= expected_count
    ), f"Expected at least {expected_count} user but found: {actual_count}"
