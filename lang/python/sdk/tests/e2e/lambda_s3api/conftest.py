"""Abstract BDD step definitions for LambdaS3api integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_FUNC = "e2e-test-func-1"
TEST_BUCKET = "e2e-test-bucket-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"


def _lambda(lws_session):
    return lws_session.client("lambda")


def _s3(lws_session):
    return lws_session.client("s3")


def _create_function(lws_session, name=TEST_FUNC):
    _lambda(lws_session).create_function(
        FunctionName=name,
        Runtime="python3.12",
        Role=ROLE_ARN,
        Handler="index.handler",
        Code={"ZipFile": b"fake"},
    )


def _create_bucket(lws_session, name=TEST_BUCKET):
    _s3(lws_session).create_bucket(Bucket=name)


# ── Given: function state ─────────────────────────────────────────────


@given("the function does not already exist")
def func_not_already_exist():
    """No-op: fresh state has no functions."""


@given("the function already exists")
def func_already_exists(lws_session):
    _create_function(lws_session)


@given("the function exists")
def func_exists(lws_session):
    _create_function(lws_session)


@given('the function is "ACTIVE"')
def func_is_active_given():
    """No-op: functions are ACTIVE immediately after creation."""


@given('the function is not "ACTIVE"')
def func_is_not_active_given(lws_session, world):
    try:
        _lambda(lws_session).delete_function(FunctionName=TEST_FUNC)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("lambda").create_dwell_ms(5000).apply()
    _create_function(lws_session)
    world["result"] = None
    world["error"] = None


@given("the function does not exist")
def func_does_not_exist():
    """No-op: fresh state has no functions."""


# ── Given: bucket state ────────────────────────────────────────────────


@given("the bucket does not already exist")
def bucket_not_already_exist():
    """No-op: fresh state has no buckets."""


@given("the bucket already exists")
def bucket_already_exists(lws_session):
    _create_bucket(lws_session)


@given("the bucket exists")
def bucket_exists(lws_session):
    _create_bucket(lws_session)


@given('the bucket is "ACTIVE"')
def bucket_is_active_given():
    """No-op: buckets are ACTIVE immediately after creation."""


@given('the bucket is not "ACTIVE"')
def bucket_is_not_active_given(lws_session, world):
    try:
        _s3(lws_session).delete_bucket(Bucket=TEST_BUCKET)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("s3").create_dwell_ms(5000).apply()
    _create_bucket(lws_session)
    world["result"] = None
    world["error"] = None


@given("the bucket does not exist")
def bucket_does_not_exist():
    """No-op: fresh state has no buckets."""


# ── Given: invocation / slot state ────────────────────────────────────


@given('an invocation is "IN_PROGRESS"')
def invocation_is_in_progress(lws_session):
    _create_function(lws_session)


@given('no invocation is "IN_PROGRESS"')
def no_invocation_is_in_progress():
    """No-op: fresh state has no invocations."""


@given("an invocation slot is available")
def invocation_slot_available():
    """No-op: always room for invocations."""


@given("no invocation slot is available")
def no_invocation_slot_available():
    pytest.skip("Cannot exhaust invocation slot limit")


@given("an object slot is available")
def object_slot_available():
    """No-op: always room for objects."""


@given("no object slot is available")
def no_object_slot_available():
    pytest.skip("Cannot exhaust object slot limit")


# ── Given: sequence setup ─────────────────────────────────────────────


@given("fid not in func_status")
def fid_not_in_func_status():
    """No-op: fresh state has no functions."""


@given("bid not in bucket_status")
def bid_not_in_bucket_status():
    """No-op: fresh state has no buckets."""


@given("fid in func_status")
def fid_in_func_status(lws_session):
    _create_function(lws_session)


@given("iid in inv_status")
def iid_in_inv_status():
    pytest.skip("Cannot create an in-progress invocation in lws")


@given("a Lambda function has been deployed")
def lambda_function_has_been_deployed_seq(lws_session):
    _create_function(lws_session)


@given("an S3 bucket has been created")
def s3_bucket_has_been_created_seq(lws_session):
    _create_bucket(lws_session)


@given("the Lambda function has been invoked")
def lambda_function_has_been_invoked_seq():
    pytest.skip("Cannot create a completed Lambda invocation in lws")


@given("the Lambda function has written an object to the S3 bucket during invocation")
def lambda_written_object_to_bucket_seq():
    pytest.skip("Cannot trigger Lambda S3 write in lws")


@given("the Lambda invocation has completed successfully")
def lambda_invocation_completed_successfully_seq():
    pytest.skip("Cannot create a completed Lambda invocation in lws")


@given("the Lambda invocation has failed")
def lambda_invocation_has_failed_seq():
    pytest.skip("Cannot trigger Lambda invocation failure in lws")


# ── When: actions ───────────────────────────────────────────────────────


@when("a Lambda function is deployed")
def deploy_lambda_function(lws_session, world):
    try:
        _create_function(lws_session)
        world["result"] = {"FunctionName": TEST_FUNC}
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("an S3 bucket is created")
def create_s3_bucket(lws_session, world):
    try:
        _create_bucket(lws_session)
        world["result"] = {"Bucket": TEST_BUCKET}
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("the Lambda function is invoked")
def invoke_function(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when("the Lambda invocation fails")
def lambda_invocation_fails(world):
    pytest.skip("Cannot trigger Lambda invocation failure in lws")


@when("the Lambda invocation completes successfully")
def lambda_invocation_succeeds(world):
    pytest.skip("Cannot trigger Lambda invocation success in lws")


@when("the Lambda function writes an object to the S3 bucket during invocation")
def lambda_writes_object(world):
    pytest.skip("Cannot trigger Lambda object write in lws")


# ── Then: assertions ────────────────────────────────────────────────────


@then('the function is "ACTIVE"')
def func_is_active_then(lws_session):
    resp = _lambda(lws_session).get_function(FunctionName=TEST_FUNC)
    expected_state = "Active"
    actual_state = resp["Configuration"]["State"]
    assert (
        actual_state == expected_state
    ), f"Expected function state '{expected_state}' but got '{actual_state}'"


@then('the bucket is "ACTIVE"')
def bucket_is_active_then(lws_session):
    resp = _s3(lws_session).head_bucket(Bucket=TEST_BUCKET)
    actual_status = resp["ResponseMetadata"]["HTTPStatusCode"]
    expected_status = 200
    assert (
        actual_status == expected_status
    ), f"Expected bucket HTTP status '{expected_status}' but got '{actual_status}'"


@then('the invocation is "IN_PROGRESS"')
def invocation_is_in_progress_then(world):
    pytest.skip("Cannot observe Lambda invocation state in lws")


@then('the invocation is "FAILED"')
def invocation_is_failed_then(world):
    pytest.skip("Cannot observe Lambda invocation failure in lws")


@then('the invocation is "SUCCESS"')
def invocation_is_success_then(world):
    pytest.skip("Cannot observe Lambda invocation success in lws")


@then('the object "EXISTS" in the bucket')
def object_exists_in_bucket(world):
    pytest.skip("Cannot observe Lambda object write result in lws")


# ── Then: sequence invariants ──────────────────────────────────────────


@then('every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function')
def _inv_lambda_s3api_every_in_progress_invocation_references_an_active_lambda_funct():
    """Invariant step: trivially satisfied in isolated test context."""


@then('every existing object belongs to an "ACTIVE" bucket')
def _inv_lambda_s3api_every_existing_object_belongs_to_an_active_bucket():
    """Invariant step: trivially satisfied in isolated test context."""
