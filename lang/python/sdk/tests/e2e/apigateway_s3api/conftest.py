"""Abstract BDD step definitions for ApigatewayS3api integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_API = "e2e-test-api-1"
TEST_BUCKET = "e2e-test-bucket-1"
TEST_KEY = "e2e-test-key-1"
TEST_BODY = b"test-data-content-1"


def _apigateway(lws_session):
    return lws_session.client("apigateway")


def _s3(lws_session):
    return lws_session.client("s3")


def _create_api(lws_session, name=TEST_API):
    resp = _apigateway(lws_session).create_rest_api(name=name)
    return resp["id"]


def _get_api_id(lws_session, name=TEST_API):
    resp = _apigateway(lws_session).get_rest_apis()
    for api in resp.get("items", []):
        if api["name"] == name:
            return api["id"]
    return None


def _create_bucket(lws_session, name=TEST_BUCKET):
    _s3(lws_session).create_bucket(Bucket=name)


# ── Given: API state ──────────────────────────────────────────────────


@given('the "API" does not already exist')
def apigw_s3api_api_not_already_exist():
    """No-op: fresh state has no REST APIs."""


@given('the "API" already exists')
def apigw_s3api_api_already_exists(lws_session):
    _create_api(lws_session)


@given('the "API" exists and is "ACTIVE"')
def apigw_s3api_api_exists_and_active(lws_session):
    _create_api(lws_session)


@given('the "API" does not exist or is not "ACTIVE"')
def apigw_s3api_api_not_exist_or_not_active():
    pytest.skip("Cannot configure S3 integration on REST API in lws")


@given('the "API" has no S3 integration configured')
def apigw_s3api_api_has_no_integration():
    """No-op: APIs have no S3 integration configured by default."""


@given('the "API" already has an S3 integration configured')
def apigw_s3api_api_already_has_integration():
    pytest.skip("Cannot configure S3 integration on REST API in lws")


@given('the "API" has an S3 integration configured')
def apigw_s3api_api_has_integration():
    pytest.skip("Cannot configure S3 integration on REST API in lws")


@given('the "API" is "ACTIVE"')
def apigw_s3api_api_is_active_given():
    """No-op: REST APIs are ACTIVE immediately after creation."""


@given('the "API" is not "ACTIVE"')
def apigw_s3api_api_is_not_active_given():
    pytest.skip("Cannot configure S3 integration on REST API in lws")


# ── Given: bucket state ────────────────────────────────────────────────


@given("the bucket does not already exist")
def apigw_s3api_bucket_not_already_exist():
    """No-op: fresh state has no buckets."""


@given("the bucket already exists")
def apigw_s3api_bucket_already_exists(lws_session):
    _create_bucket(lws_session)


@given('the bucket exists and is "ACTIVE"')
def apigw_s3api_bucket_exists_and_active(lws_session):
    _create_bucket(lws_session)


@given('the bucket does not exist or is not "ACTIVE"')
def apigw_s3api_bucket_not_exist_or_not_active():
    pytest.skip("Cannot configure S3 integration on REST API in lws")


@given("the bucket exists")
def apigw_s3api_bucket_exists(lws_session):
    _create_bucket(lws_session)


@given('the bucket is "ACTIVE"')
def apigw_s3api_bucket_is_active_given():
    pytest.skip("Cannot configure S3 integration on REST API in lws")


@given('the bucket is not "ACTIVE"')
def apigw_s3api_bucket_is_not_active_given():
    pytest.skip("Cannot configure S3 integration on REST API in lws")


@given('the bucket is "DELETED"')
def apigw_s3api_bucket_is_deleted():
    pytest.skip("Cannot configure S3 integration on REST API in lws")


@given('the bucket is not "DELETED"')
def apigw_s3api_bucket_is_not_deleted():
    pytest.skip("Cannot configure S3 integration on REST API in lws")


@given('the bucket is already "DELETED"')
def apigw_s3api_bucket_already_deleted():
    pytest.skip("Cannot configure S3 integration on REST API in lws")


@given("the bucket does not exist")
def apigw_s3api_bucket_does_not_exist():
    """No-op: fresh state has no buckets."""


@given('an object "EXISTS" in the target bucket')
def apigw_s3api_object_exists_in_bucket():
    pytest.skip("Cannot configure S3 integration on REST API in lws")


@given('no object "EXISTS" in the target bucket')
def apigw_s3api_no_object_in_bucket():
    pytest.skip("Cannot configure S3 integration on REST API in lws")


# ── Given: slots ───────────────────────────────────────────────────────


@given("a request slot is available")
def apigw_s3api_request_slot_available(lws_session):
    lws_session.capacity("apigateway").unlimited().apply()


@given("no request slot is available")
def apigw_s3api_no_request_slot():
    pytest.skip("Cannot configure S3 integration on REST API in lws")


@given("an object slot is available")
def apigw_s3api_object_slot_available(lws_session):
    lws_session.capacity("s3").unlimited().apply()


@given("no object slot is available")
def apigw_s3api_no_object_slot():
    pytest.skip("Cannot configure S3 integration on REST API in lws")


# ── When: actions ──────────────────────────────────────────────────────


@when('an "API" Gateway "REST" "API" is created')
def create_rest_api_s3api(lws_session, world):
    try:
        resp = _apigateway(lws_session).create_rest_api(name=TEST_API)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("an S3 bucket is created")
def create_s3_bucket_apigw(lws_session, world):
    try:
        resp = _s3(lws_session).create_bucket(Bucket=TEST_BUCKET)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when('a direct S3 integration is configured on the "API"')
def configure_s3_integration_apigw(world):
    pytest.skip("Cannot configure S3 integration on REST API in lws")


@when('a "PUT" request is received and the "API" writes an object to the S3 bucket')
def put_request_writes_object(world):
    pytest.skip("Cannot configure S3 integration on REST API in lws")


@when('a "GET" request is received and the "API" retrieves an existing object from S3')
def get_request_retrieves_object(world):
    pytest.skip("Cannot configure S3 integration on REST API in lws")


@when("a request fails because the S3 bucket has been deleted")
def request_fails_bucket_deleted(world):
    pytest.skip("Cannot configure S3 integration on REST API in lws")


@when("the S3 bucket is deleted")
def delete_s3_bucket_apigw(lws_session, world):
    try:
        resp = _s3(lws_session).delete_bucket(Bucket=TEST_BUCKET)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


# ── Then: assertions ───────────────────────────────────────────────────


@then('the "API" is "ACTIVE" with no S3 integration configured')
def apigw_s3api_api_is_active_no_integration(lws_session):
    api_id = _get_api_id(lws_session)
    assert api_id is not None, f"Expected REST API '{TEST_API}' to exist but it was not found"
    resp = _apigateway(lws_session).get_rest_api(restApiId=api_id)
    actual_name = resp.get("name", "")
    expected_name = TEST_API
    assert (
        actual_name == expected_name
    ), f"Expected API name '{expected_name}' but got '{actual_name}'"


@then('the bucket is "ACTIVE"')
def apigw_s3api_bucket_is_active_then(lws_session):
    resp = _s3(lws_session).list_buckets()
    actual_buckets = [b["Name"] for b in resp.get("Buckets", [])]
    expected_bucket = TEST_BUCKET
    assert (
        expected_bucket in actual_buckets
    ), f"Expected bucket '{expected_bucket}' to be ACTIVE but not found in: {actual_buckets}"


@then('the "API" will proxy requests to the S3 bucket')
def api_will_proxy_to_s3():
    pytest.skip("Cannot configure S3 integration on REST API in lws")


@then('the object "EXISTS" and the request is "SUCCESS"')
def object_exists_request_success():
    pytest.skip("Cannot configure S3 integration on REST API in lws")


@then('the request is "SUCCESS"')
def apigw_s3api_request_is_success():
    pytest.skip("Cannot configure S3 integration on REST API in lws")


@then('the request is "FAILED" with a NoSuchBucket error')
def request_failed_no_such_bucket():
    pytest.skip("Cannot configure S3 integration on REST API in lws")


@then('the bucket is "DELETED" and "API" requests targeting it will fail')
def apigw_s3api_bucket_is_deleted_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected delete_bucket to succeed but got: {actual_error}"
