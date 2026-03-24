"""Abstract BDD step definitions for ApigatewayStepfunctions integration spec scenarios."""

from __future__ import annotations

import json
import urllib.error
import urllib.request

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_API = "e2e-test-api-1"
TEST_SM = "test-sm-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"
PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})
_REGION = "us-east-1"
_ACCOUNT = "000000000000"
_STAGE = "prod"


def _apigateway(lws_session):
    return lws_session.client("apigateway")


def _sfn(lws_session):
    return lws_session.client("stepfunctions")


def _create_api(lws_session, name=TEST_API):
    resp = _apigateway(lws_session).create_rest_api(name=name)
    return resp["id"]


def _get_api_id(lws_session, name=TEST_API):
    resp = _apigateway(lws_session).get_rest_apis()
    for api in resp.get("items", []):
        if api["name"] == name:
            return api["id"]
    return None


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:{_REGION}:{_ACCOUNT}:stateMachine:{name}"


def _create_sm(lws_session, name=TEST_SM):
    resp = _sfn(lws_session).create_state_machine(
        name=name,
        definition=PASS_DEFINITION,
        roleArn=ROLE_ARN,
        type="EXPRESS",
    )
    return resp["stateMachineArn"]


def _configure_sfn_integration(lws_session, api_id: str) -> None:
    """Configure a direct Step Functions StartExecution integration on the root resource."""
    apigw = _apigateway(lws_session)

    resources_resp = apigw.get_resources(restApiId=api_id)
    root_resource = next(r for r in resources_resp["items"] if r["path"] == "/")
    root_resource_id = root_resource["id"]

    apigw.put_method(
        restApiId=api_id,
        resourceId=root_resource_id,
        httpMethod="POST",
        authorizationType="NONE",
    )

    integration_uri = f"arn:aws:apigateway:{_REGION}:states:action/StartExecution"
    apigw.put_integration(
        restApiId=api_id,
        resourceId=root_resource_id,
        httpMethod="POST",
        type="AWS",
        integrationHttpMethod="POST",
        uri=integration_uri,
    )

    deploy_resp = apigw.create_deployment(restApiId=api_id, description="e2e")
    apigw.create_stage(
        restApiId=api_id,
        stageName=_STAGE,
        deploymentId=deploy_resp["id"],
    )


def _invoke_api(lws_session, api_id: str, body: dict) -> dict:
    """POST to the deployed API stage root resource using urllib."""
    port = lws_session.port_for("apigateway")
    url = f"http://127.0.0.1:{port}/{api_id}/{_STAGE}/"
    data = json.dumps(body).encode()
    req = urllib.request.Request(
        url,
        data=data,
        headers={"Content-Type": "application/json"},
        method="POST",
    )
    try:
        with urllib.request.urlopen(req) as resp:
            return {"status_code": resp.status, "body": resp.read().decode()}
    except urllib.error.HTTPError as exc:
        return {"status_code": exc.code, "body": exc.read().decode()}


# ── Given: API state ──────────────────────────────────────────────────


@given('the "API" does not already exist')
def apigw_sfn_api_not_already_exist():
    """No-op: fresh state has no REST APIs."""


@given('the "API" already exists')
def apigw_sfn_api_already_exists(lws_session):
    _create_api(lws_session)


@given('the "API" exists')
def apigw_sfn_api_exists(lws_session):
    _create_api(lws_session)


@given('the "API" is "ACTIVE"')
def apigw_sfn_api_is_active_given():
    """No-op: REST APIs are ACTIVE immediately after creation."""


@given('the "API" is not "ACTIVE"')
def apigw_sfn_api_is_not_active_given():
    pytest.skip("Cannot simulate non-ACTIVE REST API in lws")


@given('the "API" does not exist')
def apigw_sfn_api_does_not_exist():
    """No-op: fresh state has no REST APIs."""


@given('the "API" has no integration configured')
def apigw_sfn_api_has_no_integration():
    """No-op: APIs have no integration configured by default."""


@given('the "API" already has an integration configured')
def apigw_sfn_api_already_has_integration():
    pytest.skip("Cannot simulate pre-configured StepFunctions integration conflict in lws")


@given('the "API" has a Step Functions integration configured')
def apigw_sfn_api_has_sfn_integration(lws_session, world):
    api_id = _get_api_id(lws_session)
    if api_id is None:
        api_id = _create_api(lws_session)
    _create_sm(lws_session)
    _configure_sfn_integration(lws_session, api_id)
    world["api_id"] = api_id


@given('the "API" has no Step Functions integration configured')
def apigw_sfn_api_has_no_sfn_integration():
    """No-op: APIs have no StepFunctions integration configured by default."""


# ── Given: state machine state ────────────────────────────────────────


@given("the state machine does not already exist")
def apigw_sfn_sm_not_already_exist():
    """No-op: fresh state has no state machines."""


@given("the state machine already exists")
def apigw_sfn_sm_already_exists(lws_session):
    _create_sm(lws_session)


@given("the state machine exists")
def apigw_sfn_sm_exists(lws_session):
    _create_sm(lws_session)


@given('the state machine is "ACTIVE"')
def apigw_sfn_sm_is_active_given():
    """No-op: state machines are ACTIVE immediately after creation."""


@given('the state machine is not "ACTIVE"')
def apigw_sfn_sm_is_not_active_given():
    pytest.skip("Cannot simulate non-ACTIVE state machine in lws")


@given("the state machine does not exist")
def apigw_sfn_sm_does_not_exist():
    """No-op: fresh state has no state machines."""


@given('the integrated state machine is "ACTIVE"')
def apigw_sfn_integrated_sm_is_active(lws_session):
    _create_sm(lws_session)


@given('the integrated state machine is not "ACTIVE"')
def apigw_sfn_integrated_sm_is_not_active():
    pytest.skip("Cannot simulate non-ACTIVE integrated state machine in lws")


# ── Given: execution state ────────────────────────────────────────────


@given('an execution is "RUNNING"')
def apigw_sfn_execution_is_running():
    pytest.skip("Cannot simulate running execution state in lws")


@given('no execution is "RUNNING"')
def apigw_sfn_no_execution_is_running():
    """No-op: fresh state has no running executions."""


# ── Given: slots ───────────────────────────────────────────────────────


@given("a request slot is available")
def apigw_sfn_request_slot_available(lws_session):
    lws_session.capacity("apigateway").unlimited().apply()


@given("no request slot is available")
def apigw_sfn_no_request_slot():
    pytest.skip("Cannot simulate exhausted request slots in lws")


@given("an execution slot is available")
def apigw_sfn_execution_slot_available(lws_session):
    lws_session.capacity("stepfunctions").unlimited().apply()


@given("no execution slot is available")
def apigw_sfn_no_execution_slot():
    pytest.skip("Cannot simulate exhausted execution slots in lws")


# ── When: actions ──────────────────────────────────────────────────────


@when('a "REST" "API" is created')
def create_rest_api_sfn(lws_session, world):
    try:
        resp = _apigateway(lws_session).create_rest_api(name=TEST_API)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("a Step Functions Express Workflow state machine is created")
def create_sfn_state_machine_apigw(lws_session, world):
    try:
        resp = _sfn(lws_session).create_state_machine(
            name=TEST_SM,
            definition=PASS_DEFINITION,
            roleArn=ROLE_ARN,
            type="EXPRESS",
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when('a Step Functions direct integration is configured on the "REST" "API"')
def configure_sfn_integration_apigw(lws_session, world):
    try:
        api_id = _get_api_id(lws_session)
        if api_id is None:
            world["result"] = None
            world["error"] = Exception("REST API not found")
            return
        _configure_sfn_integration(lws_session, api_id)
        world["result"] = {"configured": True}
        world["error"] = None
        world["api_id"] = api_id
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when('the "API" receives an "HTTP" request and synchronously starts a Step Functions execution')
def api_receives_request_starts_execution(lws_session, world):
    try:
        api_id = world.get("api_id") or _get_api_id(lws_session)
        resp = _invoke_api(
            lws_session,
            api_id,
            {"stateMachineArn": _sm_arn(), "input": json.dumps({"key": "value"})},
        )
        world["result"] = resp
        world["error"] = None
        world["invoke_status"] = resp["status_code"]
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when(
    'the Step Functions execution completes successfully and the "API" '
    "returns a successful response"
)
def sfn_execution_succeeds_apigw(world):
    pytest.skip("Cannot simulate Step Functions execution completion via API Gateway in lws")


@when('the Step Functions execution fails and the "API" returns an error response')
def sfn_execution_fails_apigw(world):
    pytest.skip("Cannot simulate Step Functions execution failure via API Gateway in lws")


# ── Then: assertions ───────────────────────────────────────────────────


@then('the "API" is "ACTIVE" with no Step Functions integration configured')
def apigw_sfn_api_is_active_no_integration(lws_session):
    api_id = _get_api_id(lws_session)
    assert api_id is not None, f"Expected REST API '{TEST_API}' to exist but it was not found"
    resp = _apigateway(lws_session).get_rest_api(restApiId=api_id)
    actual_name = resp.get("name", "")
    expected_name = TEST_API
    assert (
        actual_name == expected_name
    ), f"Expected API name '{expected_name}' but got '{actual_name}'"


@then('the state machine is "ACTIVE"')
def apigw_sfn_sm_is_active_then(lws_session):
    resp = _sfn(lws_session).describe_state_machine(stateMachineArn=_sm_arn())
    expected_status = "ACTIVE"
    actual_status = resp.get("status", "")
    assert (
        actual_status == expected_status
    ), f"Expected state machine status '{expected_status}' but got '{actual_status}'"


@then('the "API" will synchronously start and await an Express Workflow execution per request')
def api_will_start_execution(lws_session, world):
    api_id = world.get("api_id") or _get_api_id(lws_session)
    assert api_id is not None, "Expected API to exist"
    resp = _invoke_api(
        lws_session,
        api_id,
        {"stateMachineArn": _sm_arn(), "input": json.dumps({"check": "ok"})},
    )
    expected_status = 200
    actual_status = resp["status_code"]
    assert (
        actual_status == expected_status
    ), f"Expected status {expected_status!r} but got {actual_status!r}: {resp['body']}"


@then('the request and execution are both "IN_PROGRESS" and "RUNNING" respectively')
def request_in_progress_execution_running():
    pytest.skip("Cannot inspect in-progress execution state via API Gateway in lws")


@then('the execution is "SUCCEEDED" and the request is "SUCCESS"')
def execution_succeeded_request_success(world):
    expected_status = 200
    actual_status = world.get("invoke_status")
    assert (
        actual_status == expected_status
    ), f"Expected request status {expected_status!r} but got {actual_status!r}"


@then('the execution is "FAILED" and the request is "FAILED"')
def execution_failed_request_failed():
    pytest.skip("Cannot simulate Step Functions execution failure via API Gateway in lws")
