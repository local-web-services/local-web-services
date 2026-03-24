"""Abstract BDD step definitions for ApigatewaySqs integration spec scenarios."""

from __future__ import annotations

import json
import urllib.error
import urllib.request

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_API = "e2e-test-api-1"
TEST_QUEUE = "e2e-test-q1"
_REGION = "us-east-1"
_ACCOUNT = "000000000000"
_STAGE = "prod"


def _apigateway(lws_session):
    return lws_session.client("apigateway")


def _sqs(lws_session):
    return lws_session.client("sqs")


def _create_api(lws_session, name=TEST_API):
    resp = _apigateway(lws_session).create_rest_api(name=name)
    return resp["id"]


def _get_api_id(lws_session, name=TEST_API):
    resp = _apigateway(lws_session).get_rest_apis()
    for api in resp.get("items", []):
        if api["name"] == name:
            return api["id"]
    return None


def _create_queue(lws_session, name=TEST_QUEUE):
    _sqs(lws_session).create_queue(QueueName=name)


def _queue_url(lws_session, name=TEST_QUEUE):
    return lws_session.queue_url(name)


def _configure_sqs_integration(lws_session, api_id: str) -> None:
    """Configure a direct SQS SendMessage integration on the root resource."""
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

    integration_uri = f"arn:aws:apigateway:{_REGION}:sqs:path/{_ACCOUNT}/{TEST_QUEUE}"
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
def apigw_sqs_api_not_already_exist():
    """No-op: fresh state has no REST APIs."""


@given('the "API" already exists')
def apigw_sqs_api_already_exists(lws_session):
    _create_api(lws_session)


@given('the "API" exists')
def apigw_sqs_api_exists(lws_session):
    _create_api(lws_session)


@given('the "API" is "ACTIVE"')
def apigw_sqs_api_is_active_given():
    """No-op: REST APIs are ACTIVE immediately after creation."""


@given('the "API" is not "ACTIVE"')
def apigw_sqs_api_is_not_active_given():
    pytest.skip("Cannot simulate non-ACTIVE REST API in lws")


@given('the "API" does not exist')
def apigw_sqs_api_does_not_exist():
    """No-op: fresh state has no REST APIs."""


@given('the "API" has no integration configured')
def apigw_sqs_api_has_no_integration():
    """No-op: APIs have no integration configured by default."""


@given('the "API" already has an integration configured')
def apigw_sqs_api_already_has_integration():
    pytest.skip("Cannot simulate pre-configured SQS integration conflict in lws")


@given('the "API" has an "SQS" integration configured')
def apigw_sqs_api_has_sqs_integration(lws_session, world):
    api_id = _get_api_id(lws_session)
    if api_id is None:
        api_id = _create_api(lws_session)
    _create_queue(lws_session)
    _configure_sqs_integration(lws_session, api_id)
    world["api_id"] = api_id


@given('the "API" has no "SQS" integration configured')
def apigw_sqs_api_has_no_sqs_integration():
    """No-op: APIs have no SQS integration configured by default."""


# ── Given: queue state ────────────────────────────────────────────────


@given("the queue does not already exist")
def apigw_sqs_queue_not_already_exist():
    """No-op: fresh state has no queues."""


@given("the queue already exists")
def apigw_sqs_queue_already_exists(lws_session):
    _create_queue(lws_session)


@given("the queue exists")
def apigw_sqs_queue_exists(lws_session):
    _create_queue(lws_session)


@given('the queue is "ACTIVE"')
def apigw_sqs_queue_is_active_given():
    """No-op: SQS queues are ACTIVE immediately after creation."""


@given('the queue is not "ACTIVE"')
def apigw_sqs_queue_is_not_active_given():
    pytest.skip("Cannot simulate non-ACTIVE SQS queue in lws")


@given("the queue does not exist")
def apigw_sqs_queue_does_not_exist():
    """No-op: fresh state has no queues."""


@given('the target queue is "ACTIVE"')
def apigw_sqs_target_queue_is_active(lws_session):
    _create_queue(lws_session)


@given('the target queue is not "ACTIVE"')
def apigw_sqs_target_queue_is_not_active():
    pytest.skip("Cannot simulate non-ACTIVE target queue in lws")


# ── Given: message state ──────────────────────────────────────────────


@given('an "AVAILABLE" message exists in the queue')
def apigw_sqs_available_message_exists():
    pytest.skip("Cannot pre-seed queue messages for API Gateway integration test in lws")


@given('no "AVAILABLE" message exists in the queue')
def apigw_sqs_no_available_message():
    """No-op: fresh state has no messages."""


# ── Given: slots ───────────────────────────────────────────────────────


@given("a request slot is available")
def apigw_sqs_request_slot_available(lws_session):
    lws_session.capacity("apigateway").unlimited().apply()


@given("no request slot is available")
def apigw_sqs_no_request_slot():
    pytest.skip("Cannot simulate exhausted request slots in lws")


@given("a message slot is available")
def apigw_sqs_message_slot_available(lws_session):
    lws_session.capacity("sqs").unlimited().apply()


@given("no message slot is available")
def apigw_sqs_no_message_slot():
    pytest.skip("Cannot simulate exhausted message slots in lws")


# ── When: actions ──────────────────────────────────────────────────────


@when('a "REST" "API" is created')
def create_rest_api_sqs(lws_session, world):
    try:
        resp = _apigateway(lws_session).create_rest_api(name=TEST_API)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when('an "SQS" queue is created')
def create_sqs_queue_apigw(lws_session, world):
    try:
        resp = _sqs(lws_session).create_queue(QueueName=TEST_QUEUE)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when('an "SQS" direct integration is configured on the "REST" "API"')
def configure_sqs_integration_apigw(lws_session, world):
    try:
        api_id = _get_api_id(lws_session)
        if api_id is None:
            world["result"] = None
            world["error"] = Exception("REST API not found")
            return
        _configure_sqs_integration(lws_session, api_id)
        world["result"] = {"configured": True}
        world["error"] = None
        world["api_id"] = api_id
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when('the "API" receives a request and enqueues it as an "SQS" message')
def api_receives_request_enqueues(lws_session, world):
    try:
        api_id = world.get("api_id") or _get_api_id(lws_session)
        resp = _invoke_api(lws_session, api_id, {"event": "order-created", "orderId": "e2e-1"})
        world["result"] = resp
        world["error"] = None
        world["invoke_status"] = resp["status_code"]
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("a backend consumer processes the message from the queue")
def backend_consumer_processes_message(lws_session, world):
    try:
        q_url = _queue_url(lws_session, TEST_QUEUE)
        recv_resp = _sqs(lws_session).receive_message(QueueUrl=q_url, MaxNumberOfMessages=1)
        messages = recv_resp.get("Messages", [])
        if messages:
            msg = messages[0]
            _sqs(lws_session).delete_message(QueueUrl=q_url, ReceiptHandle=msg["ReceiptHandle"])
            world["result"] = {"deleted": True}
            world["error"] = None
        else:
            world["result"] = {"deleted": False}
            world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


# ── Then: assertions ───────────────────────────────────────────────────


@then('the "API" is "ACTIVE" with no "SQS" integration configured')
def apigw_sqs_api_is_active_no_integration(lws_session):
    api_id = _get_api_id(lws_session)
    assert api_id is not None, f"Expected REST API '{TEST_API}' to exist but it was not found"
    resp = _apigateway(lws_session).get_rest_api(restApiId=api_id)
    actual_name = resp.get("name", "")
    expected_name = TEST_API
    assert (
        actual_name == expected_name
    ), f"Expected API name '{expected_name}' but got '{actual_name}'"


@then('the queue is "ACTIVE"')
def apigw_sqs_queue_is_active_then(lws_session):
    resp = _sqs(lws_session).list_queues(QueueNamePrefix=TEST_QUEUE)
    actual_urls = resp.get("QueueUrls", [])
    expected_count = 1
    actual_count = len(actual_urls)
    assert (
        actual_count >= expected_count
    ), f"Expected at least {expected_count} queue but found: {actual_count}"


@then('the "API" will enqueue incoming requests as "SQS" messages without invoking Lambda')
def api_will_enqueue_requests(lws_session, world):
    api_id = world.get("api_id") or _get_api_id(lws_session)
    assert api_id is not None, "Expected API to exist"
    resp = _invoke_api(lws_session, api_id, {"event": "check", "orderId": "check-1"})
    expected_status = 200
    actual_status = resp["status_code"]
    assert (
        actual_status == expected_status
    ), f"Expected status {expected_status!r} but got {actual_status!r}: {resp['body']}"


@then('the request is "ACCEPTED" and the message is "AVAILABLE" in the queue')
def request_accepted_message_available(lws_session, world):
    expected_status = 200
    actual_status = world.get("invoke_status")
    assert (
        actual_status == expected_status
    ), f"Expected request status {expected_status!r} but got {actual_status!r}"
    q_url = _queue_url(lws_session, TEST_QUEUE)
    recv_resp = _sqs(lws_session).receive_message(QueueUrl=q_url, MaxNumberOfMessages=1)
    actual_messages = recv_resp.get("Messages", [])
    expected_count = 1
    actual_count = len(actual_messages)
    assert (
        actual_count >= expected_count
    ), f"Expected at least {expected_count} message in queue but found {actual_count}"


@then('the message is "DELETED"')
def apigw_sqs_message_is_deleted(world):
    actual_result = world.get("result")
    assert actual_result is not None, "Expected consumer to process the message but result is None"
    expected_deleted = True
    actual_deleted = actual_result.get("deleted", False)
    assert (
        actual_deleted == expected_deleted
    ), f"Expected message to be deleted but got: {actual_result}"
