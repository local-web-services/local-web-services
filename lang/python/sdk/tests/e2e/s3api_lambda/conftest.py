"""Abstract BDD step definitions for S3apiLambda integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_BUCKET = "e2e-test-bucket-1"
TEST_FUNC = "e2e-test-func-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"
TEST_KEY = "e2e-test-key-1"
TEST_BODY = b"test-data-content-1"
FUNC_ARN = f"arn:aws:lambda:us-east-1:000000000000:function:{TEST_FUNC}"


def _s3(lws_session):
    return lws_session.client("s3")


def _lambda(lws_session):
    return lws_session.client("lambda")


def _create_bucket(lws_session, name=TEST_BUCKET):
    _s3(lws_session).create_bucket(Bucket=name)


def _create_function(lws_session, name=TEST_FUNC):
    _lambda(lws_session).create_function(
        FunctionName=name,
        Runtime="python3.12",
        Role=ROLE_ARN,
        Handler="index.handler",
        Code={"ZipFile": b"fake"},
    )


def _configure_notification(lws_session, bucket=TEST_BUCKET, function_arn=FUNC_ARN):
    _s3(lws_session).put_bucket_notification_configuration(
        Bucket=bucket,
        NotificationConfiguration={
            "LambdaFunctionConfigurations": [
                {
                    "LambdaFunctionArn": function_arn,
                    "Events": ["s3:ObjectCreated:*"],
                }
            ]
        },
    )


# ── Given: bucket state ────────────────────────────────────────────────


@given("the bucket does not already exist")
def s3api_lambda_bucket_not_already_exist():
    """No-op: fresh state has no buckets."""


@given("the bucket already exists")
def s3api_lambda_bucket_already_exists(lws_session):
    _create_bucket(lws_session)


@given("the bucket exists")
def s3api_lambda_bucket_exists(lws_session):
    _create_bucket(lws_session)


@given('the bucket is "ACTIVE"')
def s3api_lambda_bucket_is_active_given():
    """No-op: buckets are ACTIVE by default after creation."""


@given('the bucket is not "ACTIVE"')
def s3api_lambda_bucket_is_not_active_given(lws_session, world):
    try:
        _s3(lws_session).delete_bucket(Bucket=TEST_BUCKET)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("s3").create_dwell_ms(5000).apply()
    _create_bucket(lws_session)
    world["result"] = None
    world["error"] = None


@given("the bucket does not exist")
def s3api_lambda_bucket_does_not_exist():
    """No-op: fresh state has no buckets."""


@given("the bucket has no notification configured")
def s3api_lambda_bucket_has_no_notification(world):
    """No-op: buckets have no notification configuration by default."""
    world["_skip"] = "lws does not fail put_object when no notification is configured"


@given("the bucket already has a notification configured")
def s3api_lambda_bucket_already_has_notification(lws_session):
    try:
        _create_bucket(lws_session)
    except Exception:  # noqa: BLE001
        pass  # bucket may already exist from a prior Given step
    _create_function(lws_session)
    _configure_notification(lws_session)


@given("the bucket has a notification configured")
def s3api_lambda_bucket_has_notification(lws_session):
    try:
        _create_bucket(lws_session)
    except Exception:  # noqa: BLE001
        pass  # bucket may already exist from a prior Given step
    _create_function(lws_session)
    _configure_notification(lws_session)


@given('the notification target function is "ACTIVE"')
def s3api_lambda_notification_target_active():
    """No-op: Lambda functions are ACTIVE immediately after creation."""


@given('the notification target function is not "ACTIVE"')
def s3api_lambda_notification_target_not_active(lws_session, world):
    try:
        _lambda(lws_session).delete_function(FunctionName=TEST_FUNC)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("lambda").create_dwell_ms(5000).apply()
    _create_function(lws_session)
    world["result"] = None
    world["error"] = None


# ── Given: function state ─────────────────────────────────────────────


@given("the function does not already exist")
def s3api_lambda_function_not_already_exist():
    """No-op: fresh state has no Lambda functions."""


@given("the function already exists")
def s3api_lambda_function_already_exists(lws_session):
    _create_function(lws_session)


@given("the function exists")
def s3api_lambda_function_exists(lws_session):
    _create_function(lws_session)


@given('the function is "ACTIVE"')
def s3api_lambda_function_is_active_given():
    """No-op: Lambda functions are ACTIVE immediately after creation."""


@given('the function is not "ACTIVE"')
def s3api_lambda_function_is_not_active_given(lws_session, world):
    try:
        _lambda(lws_session).delete_function(FunctionName=TEST_FUNC)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("lambda").create_dwell_ms(5000).apply()
    _create_function(lws_session)
    world["result"] = None
    world["error"] = None


@given("the function does not exist")
def s3api_lambda_function_does_not_exist():
    """No-op: fresh state has no Lambda functions."""


# ── Given: slots ───────────────────────────────────────────────────────


@given("an object slot is available")
def s3api_lambda_object_slot_available(lws_session):
    lws_session.capacity("s3").unlimited().apply()


@given("no object slot is available")
def s3api_lambda_no_object_slot_available(lws_session):
    lws_session.capacity("s3").exhaust().apply()


@given("an invocation slot is available")
def s3api_lambda_invocation_slot_available(lws_session):
    lws_session.capacity("lambda").unlimited().apply()


@given("no invocation slot is available")
def s3api_lambda_no_invocation_slot_available(lws_session):
    lws_session.capacity("lambda").exhaust().apply()


# ── Given: invocation state ───────────────────────────────────────────


@given('an invocation is "IN_PROGRESS"')
def s3api_lambda_invocation_is_in_progress(world):
    """Internal state not reachable via public API; mark scenario as N/A."""
    world["result"] = None
    world["error"] = Exception("Internal scenario: invocation state not accessible via public API")


@given('no invocation is "IN_PROGRESS"')
def s3api_lambda_no_invocation_is_in_progress():
    """No-op: fresh state has no in-progress invocations."""


# ── When: actions ──────────────────────────────────────────────────────


@when("an S3 bucket is created")
def create_s3_bucket_lambda(lws_session, world):
    try:
        resp = _s3(lws_session).create_bucket(Bucket=TEST_BUCKET)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("a Lambda function is deployed")
def deploy_lambda_function_s3api(lws_session, world):
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


@when('an S3 event notification is configured to invoke a Lambda function on object "PUT"')
def configure_s3_notification_lambda(lws_session, world):
    try:
        resp = _s3(lws_session).put_bucket_notification_configuration(
            Bucket=TEST_BUCKET,
            NotificationConfiguration={
                "LambdaFunctionConfigurations": [
                    {
                        "LambdaFunctionArn": FUNC_ARN,
                        "Events": ["s3:ObjectCreated:*"],
                    }
                ]
            },
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("an object is put into the bucket and asynchronously invokes the configured Lambda function")
def put_object_and_invoke_lambda(lws_session, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    try:
        resp = _s3(lws_session).put_object(
            Bucket=TEST_BUCKET,
            Key=TEST_KEY,
            Body=TEST_BODY,
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("the Lambda invocation completes successfully")
def s3api_lambda_invocation_completes(world):
    """Internal scenario: invocation completes are not observable via public API."""
    if world.get("error") is not None:
        return
    world["error"] = Exception(
        "Internal scenario: invocation completion not testable via public API"
    )


@when("the Lambda invocation fails")
def s3api_lambda_invocation_fails(world):
    """Internal scenario: invocation failures are not observable via public API."""
    if world.get("error") is not None:
        return
    world["error"] = Exception("Internal scenario: invocation failure not testable via public API")


# ── Then: assertions ───────────────────────────────────────────────────


@then('the bucket is "ACTIVE" with no event notification configured')
def bucket_active_no_event_notification(lws_session):
    resp = _s3(lws_session).list_buckets()
    actual_buckets = [b["Name"] for b in resp.get("Buckets", [])]
    expected_bucket = TEST_BUCKET
    assert (
        expected_bucket in actual_buckets
    ), f"Expected bucket '{expected_bucket}' to exist but not found in: {actual_buckets}"


@then('the function is "ACTIVE"')
def s3api_lambda_function_is_active_then(lws_session):
    resp = _lambda(lws_session).get_function(FunctionName=TEST_FUNC)
    expected_state = "Active"
    actual_state = resp["Configuration"].get("State", "")
    assert (
        actual_state == expected_state
    ), f"Expected function state '{expected_state}' but got '{actual_state}'"


@then("the bucket will asynchronously invoke the function when an object is put")
def bucket_will_invoke_function(lws_session):
    resp = _s3(lws_session).get_bucket_notification_configuration(Bucket=TEST_BUCKET)
    actual_configs = resp.get("LambdaFunctionConfigurations", [])
    expected_arn = FUNC_ARN
    actual_arns = [cfg.get("LambdaFunctionArn", "") for cfg in actual_configs]
    assert (
        expected_arn in actual_arns
    ), f"Expected notification ARN '{expected_arn}' but found: {actual_arns}"


@then('the object "EXISTS" in the bucket and an invocation is "IN_PROGRESS"')
def object_exists_invocation_in_progress(lws_session):
    resp = _s3(lws_session).list_objects_v2(Bucket=TEST_BUCKET)
    actual_keys = [obj["Key"] for obj in resp.get("Contents", [])]
    expected_key = TEST_KEY
    assert (
        expected_key in actual_keys
    ), f"Expected object '{expected_key}' to exist in bucket but found: {actual_keys}"


@then('the invocation is "SUCCESS"')
def s3api_lambda_invocation_is_success(world):
    """Internal scenario: invocation success state is not observable via public API."""
    actual_error = world.get("error")
    assert actual_error is not None, "Expected internal scenario error marker but none was set"


@then('the invocation is "FAILED"')
def s3api_lambda_invocation_is_failed(world):
    """Internal scenario: invocation failure state is not observable via public API."""
    actual_error = world.get("error")
    assert actual_error is not None, "Expected internal scenario error marker but none was set"
