"""Then: the pool is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..client import LambdaCognitoTestClient


@then('the pool is "ACTIVE"')
def pool_is_active_then(lws_session):
    pool_id = LambdaCognitoTestClient(lws_session).pool_id()
    resp = lws_session.client("cognito-idp").describe_user_pool(UserPoolId=pool_id)
    expected_statuses = ("Active", "Enabled")
    actual_status = resp["UserPool"]["Status"]
    assert (
        actual_status in expected_statuses
    ), f"Expected pool status in {expected_statuses!r} but got '{actual_status}'"
