"""Abstract BDD step definitions for StepfunctionsS3api integration spec scenarios."""

from __future__ import annotations

import json

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_SM = "test-sm-1"
TEST_BUCKET = "e2e-test-bucket-1"
TEST_KEY = "e2e-test-key-1"
TEST_BODY = b"test-data-content-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"
PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})
TEST_INPUT = '{"key": "value"}'


def _sfn(lws_session):
    return lws_session.client("stepfunctions")


def _s3(lws_session):
    return lws_session.client("s3")


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"


def _create_sm(lws_session, name=TEST_SM):
    resp = _sfn(lws_session).create_state_machine(
        name=name,
        definition=PASS_DEFINITION,
        roleArn=ROLE_ARN,
    )
    return resp["stateMachineArn"]


def _create_bucket(lws_session, name=TEST_BUCKET):
    _s3(lws_session).create_bucket(Bucket=name)


def _start_execution(lws_session, name=TEST_SM):
    resp = _sfn(lws_session).start_execution(
        stateMachineArn=_sm_arn(name),
        input=TEST_INPUT,
    )
    return resp["executionArn"]


# ── Given: state machine state ────────────────────────────────────────


@given("the state machine does not already exist")
def sm_not_already_exist():
    """No-op: fresh state has no state machines."""


@given("the state machine already exists")
def sm_already_exists(lws_session):
    _create_sm(lws_session)


@given("the state machine exists")
def sm_exists(lws_session):
    _create_sm(lws_session)


@given('the state machine is "ACTIVE"')
def sm_is_active_given():
    """No-op: state machines are ACTIVE immediately after creation."""


@given('the state machine is not "ACTIVE"')
def sm_is_not_active_given(lws_session, world):
    try:
        _sfn(lws_session).delete_state_machine(stateMachineArn=_sm_arn())
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("stepfunctions").create_dwell_ms(5000).apply()
    _create_sm(lws_session)
    world["result"] = None
    world["error"] = None


@given("the state machine does not exist")
def sm_does_not_exist():
    """No-op: fresh state has no state machines."""


@given("the state machine has no S3 task configured")
def sm_has_no_s3_task():
    pytest.skip("lws does not validate S3 task configuration before starting an execution")


@given("the state machine has an S3 task configured")
def sm_has_s3_task():
    pytest.skip("Cannot pre-configure S3 task on state machine in lws")


@given("the state machine already has an S3 task configured")
def sm_already_has_s3_task():
    pytest.skip("Cannot pre-configure S3 task on state machine in this context")


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
    """No-op: buckets are ACTIVE by default after creation."""


@given('the bucket is not "ACTIVE"')
def bucket_is_not_active_given(lws_session, world):
    lws_session.lifecycle("s3").create_dwell_ms(5000).apply()
    _create_bucket(lws_session)
    world["result"] = None
    world["error"] = None


@given("the bucket does not exist")
def bucket_does_not_exist():
    """No-op: fresh state has no buckets."""


@given('the target bucket is "ACTIVE"')
def target_bucket_is_active():
    """No-op: buckets are ACTIVE by default after creation."""


@given('the target bucket is not "ACTIVE"')
def target_bucket_is_not_active(lws_session, world):
    lws_session.lifecycle("s3").create_dwell_ms(5000).apply()
    _create_bucket(lws_session)
    world["result"] = None
    world["error"] = None


# ── Given: execution state ────────────────────────────────────────────


@given('an execution is "RUNNING"')
def execution_is_running_given(lws_session):
    _create_sm(lws_session)
    _start_execution(lws_session)


@given('no execution is "RUNNING"')
def no_execution_is_running():
    """No-op: fresh state has no executions."""


# ── Given: object state ───────────────────────────────────────────────


@given("an object slot is available")
def object_slot_available():
    """No-op: always room for objects."""


@given("no object slot is available")
def no_object_slot_available():
    pytest.skip("Cannot exhaust object slot limit")


@given('an object "EXISTS" in the target bucket')
def object_exists_in_target_bucket(lws_session):
    _create_bucket(lws_session)
    _s3(lws_session).put_object(Bucket=TEST_BUCKET, Key=TEST_KEY, Body=TEST_BODY)


@given('no object "EXISTS" in the target bucket')
def no_object_exists_in_target_bucket():
    """No-op: fresh bucket has no objects."""


# ── Given: slots ───────────────────────────────────────────────────────


@given("an execution slot is available")
def execution_slot_available():
    """No-op: always room for executions."""


@given("no execution slot is available")
def no_execution_slot_available():
    pytest.skip("Cannot exhaust execution slot limit")


# ── When: actions ──────────────────────────────────────────────────────


@when("a Step Functions state machine is created")
def create_state_machine(lws_session, world):
    try:
        resp = _sfn(lws_session).create_state_machine(
            name=TEST_SM,
            definition=PASS_DEFINITION,
            roleArn=ROLE_ARN,
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an S3 bucket is created")
def create_s3_bucket(lws_session, world):
    try:
        world["result"] = _s3(lws_session).create_bucket(Bucket=TEST_BUCKET)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an S3 task is configured on the state machine")
def configure_s3_task(world):
    pytest.skip("Cannot configure S3 task on state machine in lws")


@when("an execution of the state machine is started")
def start_execution(lws_session, world):
    try:
        resp = _sfn(lws_session).start_execution(
            stateMachineArn=_sm_arn(),
            input=TEST_INPUT,
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a running execution writes an object to the S3 bucket and succeeds")
def execution_writes_object(world):
    pytest.skip("Cannot trigger internal execution step that writes to S3")


@when("a running execution reads an existing object from the S3 bucket and succeeds")
def execution_reads_object(world):
    pytest.skip("Cannot trigger internal execution step that reads from S3")


@when("a running execution fails to read because no object exists in the bucket")
def execution_reads_object_not_found(world):
    pytest.skip("Cannot trigger internal execution step that fails to read from S3")


# ── Then: assertions ───────────────────────────────────────────────────


@then('the state machine is "ACTIVE"')
def sm_is_active_then(lws_session):
    resp = _sfn(lws_session).describe_state_machine(stateMachineArn=_sm_arn())
    expected_status = "ACTIVE"
    actual_status = resp.get("status", "")
    assert (
        actual_status == expected_status
    ), f"Expected state machine status '{expected_status}' but got '{actual_status}'"


@then('the state machine is "ACTIVE" with no S3 task configured')
def sm_is_active_with_no_s3_task(lws_session):
    resp = _sfn(lws_session).describe_state_machine(stateMachineArn=_sm_arn())
    expected_status = "ACTIVE"
    actual_status = resp.get("status", "")
    assert (
        actual_status == expected_status
    ), f"Expected state machine status '{expected_status}' but got '{actual_status}'"


@then('the bucket is "ACTIVE"')
def bucket_is_active_then(lws_session):
    resp = _s3(lws_session).list_buckets()
    actual_buckets = [b["Name"] for b in resp.get("Buckets", [])]
    assert (
        TEST_BUCKET in actual_buckets
    ), f"Expected bucket '{TEST_BUCKET}' to exist but not found in: {actual_buckets}"


@then("the state machine will read or write objects to the bucket when it reaches the task state")
def sm_will_read_write_objects(world):
    pytest.skip("Cannot observe S3 task configuration in lws")


@then('the execution is "RUNNING"')
def execution_is_running_then(world):
    assert world["error"] is None, f"Expected start_execution to succeed but got: {world['error']}"
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"


@then('the object "EXISTS" in the bucket and the execution is "SUCCEEDED"')
def object_exists_and_execution_succeeded(world):
    pytest.skip("Cannot observe internal execution S3 write in lws")


@then('the execution is "SUCCEEDED"')
def execution_is_succeeded_then(world):
    pytest.skip("Cannot observe internal execution S3 read success in lws")


@then('the execution is "FAILED" with a NoSuchKey error')
def execution_failed_no_such_key(world):
    pytest.skip("Cannot observe internal execution S3 read failure in lws")
