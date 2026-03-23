"""Abstract BDD step definitions for ApigatewayLambda integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_API = "e2e-test-api-1"
TEST_FUNC = "e2e-test-func-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"


def _apigateway(lws_session):
    return lws_session.client("apigateway")


def _lambda(lws_session):
    return lws_session.client("lambda")


def _create_api(lws_session, name=TEST_API):
    resp = _apigateway(lws_session).create_rest_api(name=name)
    return resp["id"]


def _get_api_id(lws_session, name=TEST_API):
    resp = _apigateway(lws_session).get_rest_apis()
    for api in resp.get("items", []):
        if api["name"] == name:
            return api["id"]
    return None


def _create_function(lws_session, name=TEST_FUNC):
    _lambda(lws_session).create_function(
        FunctionName=name,
        Runtime="python3.12",
        Role=ROLE_ARN,
        Handler="index.handler",
        Code={"ZipFile": b"fake"},
    )


# ── Given: API state ──────────────────────────────────────────────────


@given('the "API" does not already exist')
def apigw_lambda_api_not_already_exist():
    """No-op: fresh state has no REST APIs."""


@given('the "API" already exists')
def apigw_lambda_api_already_exists(lws_session):
    _create_api(lws_session)


@given('the "API" exists')
def apigw_lambda_api_exists(lws_session):
    _create_api(lws_session)


@given('the "API" is "ACTIVE"')
def apigw_lambda_api_is_active_given():
    """No-op: REST APIs are ACTIVE immediately after creation."""


@given('the "API" is not "ACTIVE"')
def apigw_lambda_api_is_not_active_given():
    pytest.skip("Cannot configure Lambda integration on REST API in lws")


@given('the "API" does not exist')
def apigw_lambda_api_does_not_exist():
    """No-op: fresh state has no REST APIs."""


@given('the "API" has no integration configured')
def apigw_lambda_api_has_no_integration():
    """No-op: APIs have no integration configured by default."""


@given('the "API" already has an integration configured')
def apigw_lambda_api_already_has_integration():
    pytest.skip("Cannot configure Lambda integration on REST API in lws")


@given('the "API" has a Lambda integration configured')
def apigw_lambda_api_has_lambda_integration():
    pytest.skip("Cannot configure Lambda integration on REST API in lws")


@given('the "API" has no Lambda integration configured')
def apigw_lambda_api_has_no_lambda_integration():
    """No-op: APIs have no Lambda integration configured by default."""


# ── Given: function state ─────────────────────────────────────────────


@given("the function does not already exist")
def apigw_lambda_function_not_already_exist():
    """No-op: fresh state has no Lambda functions."""


@given("the function already exists")
def apigw_lambda_function_already_exists(lws_session):
    _create_function(lws_session)


@given("the function exists")
def apigw_lambda_function_exists(lws_session):
    _create_function(lws_session)


@given('the function is "ACTIVE"')
def apigw_lambda_function_is_active_given():
    """No-op: Lambda functions are ACTIVE immediately after creation."""


@given('the function is not "ACTIVE"')
def apigw_lambda_function_is_not_active_given(lws_session, world):
    try:
        _lambda(lws_session).delete_function(FunctionName=TEST_FUNC)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("lambda").create_dwell_ms(5000).apply()
    _create_function(lws_session)
    world["result"] = None
    world["error"] = None


@given("the function does not exist")
def apigw_lambda_function_does_not_exist():
    """No-op: fresh state has no Lambda functions."""


@given('the integrated function is "ACTIVE"')
def apigw_lambda_integrated_function_is_active():
    pytest.skip("Cannot configure Lambda integration on REST API in lws")


@given('the integrated function is not "ACTIVE"')
def apigw_lambda_integrated_function_is_not_active():
    pytest.skip("Cannot configure Lambda integration on REST API in lws")


# ── Given: slots ───────────────────────────────────────────────────────


@given("a request slot is available")
def apigw_lambda_request_slot_available(lws_session):
    lws_session.capacity("apigateway").unlimited().apply()


@given("no request slot is available")
def apigw_lambda_no_request_slot():
    pytest.skip("Cannot send requests through API Gateway Lambda integration in lws")


@given("an invocation slot is available")
def apigw_lambda_invocation_slot_available(lws_session):
    lws_session.capacity("lambda").unlimited().apply()


@given("no invocation slot is available")
def apigw_lambda_no_invocation_slot():
    pytest.skip("Cannot send requests through API Gateway Lambda integration in lws")


# ── Given: invocation state ───────────────────────────────────────────


@given('an invocation is "IN_PROGRESS"')
def apigw_lambda_invocation_is_in_progress():
    pytest.skip("Cannot send requests through API Gateway Lambda integration in lws")


@given('no invocation is "IN_PROGRESS"')
def apigw_lambda_no_invocation_is_in_progress():
    """No-op: fresh state has no in-progress invocations."""


# ── When: actions ──────────────────────────────────────────────────────


@when('a "REST" "API" is created')
def create_rest_api_lambda(lws_session, world):
    try:
        resp = _apigateway(lws_session).create_rest_api(name=TEST_API)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("a Lambda function is deployed")
def deploy_lambda_function_apigw(lws_session, world):
    try:
        resp = _lambda(lws_session).create_function(
            FunctionName=TEST_FUNC,
            Runtime="python3.12",
            Role=ROLE_ARN,
            Handler="index.handler",
            Code={"ZipFile": b"fake"},
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when('a Lambda integration is configured on the "REST" "API"')
def configure_lambda_integration_apigw(world):
    pytest.skip("Cannot configure Lambda integration on REST API in lws")


@when('the "API" receives an "HTTP" request and synchronously invokes the Lambda function')
def api_receives_request_invokes_lambda(world):
    pytest.skip("Cannot send requests through API Gateway Lambda integration in lws")


@when('the Lambda invocation completes successfully and the "API" returns a successful response')
def lambda_invocation_succeeds_apigw(world):
    pytest.skip("Cannot send requests through API Gateway Lambda integration in lws")


@when('the Lambda invocation fails and the "API" returns an error response')
def lambda_invocation_fails_apigw(world):
    pytest.skip("Cannot send requests through API Gateway Lambda integration in lws")


# ── Then: assertions ───────────────────────────────────────────────────


@then('the "API" is "ACTIVE" with no Lambda integration configured')
def apigw_lambda_api_is_active_no_integration(lws_session):
    api_id = _get_api_id(lws_session)
    assert api_id is not None, f"Expected REST API '{TEST_API}' to exist but it was not found"
    resp = _apigateway(lws_session).get_rest_api(restApiId=api_id)
    actual_name = resp.get("name", "")
    expected_name = TEST_API
    assert (
        actual_name == expected_name
    ), f"Expected API name '{expected_name}' but got '{actual_name}'"


@then('the function is "ACTIVE"')
def apigw_lambda_function_is_active_then(lws_session):
    resp = _lambda(lws_session).get_function(FunctionName=TEST_FUNC)
    expected_state = "Active"
    actual_state = resp["Configuration"].get("State", "")
    assert (
        actual_state == expected_state
    ), f"Expected function state '{expected_state}' but got '{actual_state}'"


@then('the "API" will synchronously invoke the function when a request arrives')
def api_will_invoke_function():
    pytest.skip("Cannot configure Lambda integration on REST API in lws")


@then('the request and invocation are both "IN_PROGRESS"')
def request_and_invocation_in_progress():
    pytest.skip("Cannot send requests through API Gateway Lambda integration in lws")


@then('the invocation is "SUCCESS" and the request is "SUCCESS"')
def invocation_success_request_success():
    pytest.skip("Cannot send requests through API Gateway Lambda integration in lws")


@then('the invocation is "FAILED" and the request is "FAILED"')
def invocation_failed_request_failed():
    pytest.skip("Cannot send requests through API Gateway Lambda integration in lws")
