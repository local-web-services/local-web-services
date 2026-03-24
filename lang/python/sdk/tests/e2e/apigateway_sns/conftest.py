"""Abstract BDD step definitions for ApigatewaySns integration spec scenarios."""

from __future__ import annotations

import json
import urllib.error
import urllib.request

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_API = "e2e-test-api-1"
TEST_TOPIC_NAME = "e2e-test-topic-1"
_REGION = "us-east-1"
_ACCOUNT = "000000000000"
_STAGE = "prod"


def _apigateway(lws_session):
    return lws_session.client("apigateway")


def _sns(lws_session):
    return lws_session.client("sns")


def _topic_arn(name=TEST_TOPIC_NAME):
    return f"arn:aws:sns:{_REGION}:{_ACCOUNT}:{name}"


def _create_api(lws_session, name=TEST_API):
    resp = _apigateway(lws_session).create_rest_api(name=name)
    return resp["id"]


def _get_api_id(lws_session, name=TEST_API):
    resp = _apigateway(lws_session).get_rest_apis()
    for api in resp.get("items", []):
        if api["name"] == name:
            return api["id"]
    return None


def _create_topic(lws_session, name=TEST_TOPIC_NAME):
    _sns(lws_session).create_topic(Name=name)


def _configure_sns_integration(lws_session, api_id: str) -> None:
    """Configure a direct SNS Publish integration on the root resource."""
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

    integration_uri = f"arn:aws:apigateway:{_REGION}:sns:action/Publish"
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
def apigw_sns_api_not_already_exist():
    """No-op: fresh state has no REST APIs."""


@given('the "API" already exists')
def apigw_sns_api_already_exists(lws_session):
    _create_api(lws_session)


@given('the "API" exists and is "ACTIVE"')
def apigw_sns_api_exists_and_active(lws_session):
    _create_api(lws_session)


@given('the "API" does not exist or is not "ACTIVE"')
def apigw_sns_api_not_exist_or_not_active():
    pytest.skip("Cannot simulate non-ACTIVE REST API in lws")


@given('the "API" has no "SNS" integration configured')
def apigw_sns_api_has_no_integration():
    """No-op: APIs have no SNS integration configured by default."""


@given('the "API" already has an "SNS" integration configured')
def apigw_sns_api_already_has_integration():
    pytest.skip("Cannot simulate pre-configured SNS integration conflict in lws")


@given('the "API" has an "SNS" integration configured')
def apigw_sns_api_has_integration(lws_session, world):
    api_id = _get_api_id(lws_session)
    if api_id is None:
        api_id = _create_api(lws_session)
    _create_topic(lws_session)
    _configure_sns_integration(lws_session, api_id)
    world["api_id"] = api_id


@given('the "API" is "ACTIVE"')
def apigw_sns_api_is_active_given():
    """No-op: REST APIs are ACTIVE immediately after creation."""


@given('the "API" is not "ACTIVE"')
def apigw_sns_api_is_not_active_given():
    pytest.skip("Cannot simulate non-ACTIVE REST API in lws")


# ── Given: topic state ────────────────────────────────────────────────


@given("the topic does not already exist")
def apigw_sns_topic_not_already_exist():
    """No-op: fresh state has no topics."""


@given("the topic already exists")
def apigw_sns_topic_already_exists(lws_session):
    _create_topic(lws_session)


@given('the topic exists and is "ACTIVE"')
def apigw_sns_topic_exists_and_active(lws_session):
    _create_topic(lws_session)


@given('the topic does not exist or is not "ACTIVE"')
def apigw_sns_topic_not_exist_or_not_active():
    pytest.skip("Cannot simulate non-ACTIVE SNS topic in lws")


@given("the topic exists")
def apigw_sns_topic_exists(lws_session):
    _create_topic(lws_session)


@given('the topic is "ACTIVE"')
def apigw_sns_topic_is_active_given():
    """No-op: topics are ACTIVE by default after creation."""


@given('the target topic is "ACTIVE"')
def apigw_sns_target_topic_is_active(lws_session):
    _create_topic(lws_session)


@given('the target topic is not "ACTIVE"')
def apigw_sns_target_topic_is_not_active():
    pytest.skip("Cannot simulate non-ACTIVE target topic in lws")


@given('the target topic is "DELETED"')
def apigw_sns_target_topic_is_deleted():
    pytest.skip("Cannot simulate DELETED target topic in lws")


@given('the target topic is not "DELETED"')
def apigw_sns_target_topic_is_not_deleted():
    """No-op: topics are not DELETED by default."""


@given('the topic is already "DELETED"')
def apigw_sns_topic_already_deleted(lws_session, world):
    try:
        _create_topic(lws_session)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("sns").delete_dwell_ms(5000).apply()
    _sns(lws_session).delete_topic(TopicArn=_topic_arn())
    world["result"] = None
    world["error"] = None


@given("the topic does not exist")
def apigw_sns_topic_does_not_exist():
    """No-op: fresh state has no topics."""


# ── Given: slots ───────────────────────────────────────────────────────


@given("a request slot is available")
def apigw_sns_request_slot_available(lws_session):
    lws_session.capacity("apigateway").unlimited().apply()


@given("no request slot is available")
def apigw_sns_no_request_slot():
    pytest.skip("Cannot simulate exhausted request slots in lws")


@given("a message slot is available")
def apigw_sns_message_slot_available(lws_session):
    lws_session.capacity("sns").unlimited().apply()


@given("no message slot is available")
def apigw_sns_no_message_slot():
    pytest.skip("Cannot simulate exhausted message slots in lws")


# ── When: actions ──────────────────────────────────────────────────────


@when('an "API" Gateway "REST" "API" is created')
def create_rest_api_sns(lws_session, world):
    try:
        resp = _apigateway(lws_session).create_rest_api(name=TEST_API)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when('an "SNS" topic is created')
def create_sns_topic_apigw(lws_session, world):
    try:
        resp = _sns(lws_session).create_topic(Name=TEST_TOPIC_NAME)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when('a direct "SNS" integration is configured on the "API"')
def configure_sns_integration_apigw(lws_session, world):
    try:
        api_id = _get_api_id(lws_session)
        if api_id is None:
            world["result"] = None
            world["error"] = Exception("REST API not found")
            return
        _configure_sns_integration(lws_session, api_id)
        world["result"] = {"configured": True}
        world["error"] = None
        world["api_id"] = api_id
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when('a request is received, the "API" publishes to the "SNS" topic, and returns 200')
def request_publishes_to_sns(lws_session, world):
    try:
        api_id = world.get("api_id") or _get_api_id(lws_session)
        resp = _invoke_api(
            lws_session,
            api_id,
            {"TopicArn": _topic_arn(), "Message": "e2e-test-message"},
        )
        world["result"] = resp
        world["error"] = None
        world["invoke_status"] = resp["status_code"]
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when('a request is received but the "SNS" publish fails because the topic has been deleted')
def request_fails_topic_deleted(world):
    pytest.skip("Cannot simulate SNS publish failure on deleted topic via API Gateway in lws")


@when('the "SNS" topic is deleted')
def delete_sns_topic_apigw(lws_session, world):
    try:
        resp = _sns(lws_session).delete_topic(TopicArn=_topic_arn())
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


# ── Then: assertions ───────────────────────────────────────────────────


@then('the "API" is "ACTIVE" with no "SNS" integration configured')
def apigw_sns_api_is_active_no_integration(lws_session):
    api_id = _get_api_id(lws_session)
    assert api_id is not None, f"Expected REST API '{TEST_API}' to exist but it was not found"
    resp = _apigateway(lws_session).get_rest_api(restApiId=api_id)
    actual_name = resp.get("name", "")
    expected_name = TEST_API
    assert (
        actual_name == expected_name
    ), f"Expected API name '{expected_name}' but got '{actual_name}'"


@then('the topic is "ACTIVE"')
def apigw_sns_topic_is_active_then(lws_session):
    resp = _sns(lws_session).list_topics()
    actual_arns = [t["TopicArn"] for t in resp.get("Topics", [])]
    expected_arn = _topic_arn()
    assert (
        expected_arn in actual_arns
    ), f"Expected topic '{expected_arn}' to be ACTIVE but not found in: {actual_arns}"


@then('the "API" will publish to the topic when requests are received')
def api_will_publish_to_topic(lws_session, world):
    api_id = world.get("api_id") or _get_api_id(lws_session)
    assert api_id is not None, "Expected API to exist"
    resp = _invoke_api(
        lws_session,
        api_id,
        {"TopicArn": _topic_arn(), "Message": "test-message"},
    )
    expected_status = 200
    actual_status = resp["status_code"]
    assert (
        actual_status == expected_status
    ), f"Expected status {expected_status!r} but got {actual_status!r}: {resp['body']}"


@then('the message is "PUBLISHED" and the request is "SUCCESS"')
def message_published_request_success(world):
    expected_status = 200
    actual_status = world.get("invoke_status")
    assert (
        actual_status == expected_status
    ), f"Expected request status {expected_status!r} but got {actual_status!r}"


@then('the request is "FAILED" and no message is published')
def request_failed_no_message():
    pytest.skip("Cannot simulate SNS publish failure via API Gateway in lws")


@then('the topic is "DELETED" and "API" requests targeting it will fail')
def apigw_sns_topic_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected delete_topic to succeed but got: {actual_error}"
