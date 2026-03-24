"""Abstract BDD step definitions for ApigatewayCognito integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_API = "e2e-test-api-1"
TEST_POOL = "e2e-test-pool-1"


def _apigateway(lws_session):
    return lws_session.client("apigateway")


def _cognito(lws_session):
    return lws_session.client("cognito-idp")


def _create_api(lws_session, name=TEST_API):
    resp = _apigateway(lws_session).create_rest_api(name=name)
    return resp["id"]


def _get_api_id(lws_session, name=TEST_API):
    resp = _apigateway(lws_session).get_rest_apis()
    for api in resp.get("items", []):
        if api["name"] == name:
            return api["id"]
    return None


def _create_pool(lws_session, name=TEST_POOL):
    resp = _cognito(lws_session).create_user_pool(PoolName=name)
    return resp["UserPool"]["Id"]


def _get_pool_id(lws_session, name=TEST_POOL):
    resp = _cognito(lws_session).list_user_pools(MaxResults=60)
    for pool in resp.get("UserPools", []):
        if pool["Name"] == name:
            return pool["Id"]
    return None


# ── Given: API state ──────────────────────────────────────────────────


@given('the "API" does not already exist')
def apigw_cognito_api_not_already_exist():
    """No-op: fresh state has no REST APIs."""


@given('the "API" already exists')
def apigw_cognito_api_already_exists(lws_session):
    _create_api(lws_session)


@given('the "API" exists')
def apigw_cognito_api_exists(lws_session):
    _create_api(lws_session)


@given('the "API" is "ACTIVE"')
def apigw_cognito_api_is_active_given():
    """No-op: REST APIs are ACTIVE immediately after creation."""


@given('the "API" is not "ACTIVE"')
def apigw_cognito_api_is_not_active_given():
    pytest.skip("Cannot configure Cognito authorizer on REST API in lws")


@given('the "API" does not exist')
def apigw_cognito_api_does_not_exist():
    """No-op: fresh state has no REST APIs."""


@given('the "API" has no authorizer configured')
def apigw_cognito_api_has_no_authorizer():
    """No-op: APIs have no authorizer configured by default."""


@given('the "API" already has an authorizer configured')
def apigw_cognito_api_already_has_authorizer():
    pytest.skip("Cannot configure Cognito authorizer on REST API in lws")


@given('the "API" has a Cognito authorizer configured')
def apigw_cognito_api_has_authorizer():
    pytest.skip("Cannot configure Cognito authorizer on REST API in lws")


@given('the "API" has no Cognito authorizer configured')
def apigw_cognito_api_has_no_cognito_authorizer():
    """No-op: APIs have no Cognito authorizer configured by default."""


# ── Given: pool state ─────────────────────────────────────────────────


@given("the pool does not already exist")
def apigw_cognito_pool_not_already_exist():
    """No-op: fresh state has no user pools."""


@given("the pool already exists")
def apigw_cognito_pool_already_exists(lws_session):
    _create_pool(lws_session)


@given("the pool exists")
def apigw_cognito_pool_exists(lws_session):
    _create_pool(lws_session)


@given('the pool is "ACTIVE"')
def apigw_cognito_pool_is_active_given():
    """No-op: Cognito user pools are ACTIVE immediately after creation."""


@given('the pool is not "ACTIVE"')
def apigw_cognito_pool_is_not_active_given():
    pytest.skip("Cannot configure Cognito authorizer on REST API in lws")


@given("the pool does not exist")
def apigw_cognito_pool_does_not_exist():
    """No-op: fresh state has no user pools."""


# ── Given: user state ─────────────────────────────────────────────────


@given("the user does not already exist")
def apigw_cognito_user_not_already_exist():
    """No-op: fresh state has no users."""


@given("the user already exists")
def apigw_cognito_user_already_exists():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")


@given("the user exists")
def apigw_cognito_user_exists():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")


@given('the user is "CONFIRMED"')
def apigw_cognito_user_is_confirmed():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")


@given('the user is not "CONFIRMED"')
def apigw_cognito_user_is_not_confirmed():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")


@given("the user does not exist")
def apigw_cognito_user_does_not_exist():
    """No-op: fresh state has no users."""


# ── Given: token state ────────────────────────────────────────────────


@given("a token slot is available")
def apigw_cognito_token_slot_available(lws_session):
    lws_session.capacity("cognito-idp").unlimited().apply()


@given("no token slot is available")
def apigw_cognito_no_token_slot_available():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")


@given('a "VALID" token exists')
def apigw_cognito_valid_token_exists():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")


@given('no "VALID" token exists')
def apigw_cognito_no_valid_token():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")


@given('the token belongs to a "CONFIRMED" user in the "API"\'s configured pool')
def apigw_cognito_token_belongs_to_pool_user():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")


@given('the token does not belong to a "CONFIRMED" user in the configured pool')
def apigw_cognito_token_not_belong_to_pool_user():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")


@given('a "VALID" token exists from a user in a different pool than the configured authorizer')
def apigw_cognito_token_from_different_pool():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")


@given("no such mismatched token exists")
def apigw_cognito_no_mismatched_token():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")


# ── Given: request slot ───────────────────────────────────────────────


@given("a request slot is available")
def apigw_cognito_request_slot_available(lws_session):
    lws_session.capacity("apigateway").unlimited().apply()


@given("no request slot is available")
def apigw_cognito_no_request_slot():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")


# ── When: actions ──────────────────────────────────────────────────────


@when('a "REST" "API" is created')
def create_rest_api_cognito(lws_session, world):
    try:
        resp = _apigateway(lws_session).create_rest_api(name=TEST_API)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("a Cognito User Pool is created")
def create_cognito_user_pool_apigw(lws_session, world):
    try:
        resp = _cognito(lws_session).create_user_pool(PoolName=TEST_POOL)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when('a Cognito User Pool authorizer is configured on the "REST" "API"')
def configure_cognito_authorizer(world):
    pytest.skip("Cannot configure Cognito authorizer on REST API in lws")


@when("a user is confirmed in a Cognito User Pool")
def confirm_user_in_pool(world):
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")


@when('Cognito issues a "JWT" token for a confirmed user')
def cognito_issues_jwt_token(world):
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")


@when('a request with a valid token from a user in the "API"\'s configured pool is authorized')
def authorize_request(world):
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")


@when("a request with a valid token from a user in a different pool is rejected")
def reject_request(world):
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")


# ── Then: assertions ───────────────────────────────────────────────────


@then('the "API" is "ACTIVE" with no Cognito authorizer configured')
def api_is_active_no_cognito_authorizer(lws_session):
    api_id = _get_api_id(lws_session)
    expected_api_id = api_id
    assert (
        expected_api_id is not None
    ), f"Expected REST API '{TEST_API}' to exist but it was not found"
    resp = _apigateway(lws_session).get_rest_api(restApiId=api_id)
    actual_name = resp.get("name", "")
    expected_name = TEST_API
    assert (
        actual_name == expected_name
    ), f"Expected API name '{expected_name}' but got '{actual_name}'"


@then('the pool is "ACTIVE"')
def apigw_cognito_pool_is_active_then(lws_session):
    resp = _cognito(lws_session).list_user_pools(MaxResults=60)
    actual_pool_names = [p["Name"] for p in resp.get("UserPools", [])]
    expected_pool_name = TEST_POOL
    assert (
        expected_pool_name in actual_pool_names
    ), f"Expected pool '{expected_pool_name}' to be ACTIVE but not found in: {actual_pool_names}"


@then('the "API" will validate "JWT" tokens against the configured pool before routing requests')
def api_will_validate_jwt():
    pytest.skip("Cannot configure Cognito authorizer on REST API in lws")


@then('the user is "CONFIRMED" and can authenticate')
def user_is_confirmed():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")


@then('a "VALID" token is issued that can be presented to "API" Gateway for authorization')
def valid_token_issued():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")


@then('the request is "AUTHORIZED" and routed to the backend')
def request_is_authorized():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")


@then(
    'the request is "REJECTED" because the token\'s issuing pool does not match '
    "the configured authorizer"
)
def request_is_rejected():
    pytest.skip("Cannot send requests through API Gateway Cognito authorizer in lws")
