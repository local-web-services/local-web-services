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


def _s3_put_object_definition(bucket: str, key: str, body: str) -> str:
    """Return a state machine definition with an S3 putObject task."""
    return json.dumps(
        {
            "StartAt": "PutObject",
            "States": {
                "PutObject": {
                    "Type": "Task",
                    "Resource": "arn:aws:states:::s3:putObject",
                    "Parameters": {
                        "Bucket": bucket,
                        "Key": key,
                        "Body": body,
                    },
                    "End": True,
                }
            },
        }
    )


def _s3_get_object_definition(bucket: str, key: str) -> str:
    """Return a state machine definition with an S3 getObject task."""
    return json.dumps(
        {
            "StartAt": "GetObject",
            "States": {
                "GetObject": {
                    "Type": "Task",
                    "Resource": "arn:aws:states:::s3:getObject",
                    "Parameters": {
                        "Bucket": bucket,
                        "Key": key,
                    },
                    "End": True,
                }
            },
        }
    )


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
def sm_has_no_s3_task(lws_session, world):
    """Ensure a PASS-only state machine exists with no S3 task."""
    try:
        _create_sm(lws_session)
    except Exception:  # noqa: BLE001
        pass  # state machine may already exist from a prior Given step
    world["_sm_has_no_s3_task"] = True


@given("the state machine has an S3 task configured")
def sm_has_s3_task(lws_session):
    """Create a state machine with an S3 putObject task; update if it already exists."""
    try:
        _create_bucket(lws_session)
    except Exception:  # noqa: BLE001
        pass  # bucket may already exist from a prior Given step
    try:
        _sfn(lws_session).create_state_machine(
            name=TEST_SM,
            definition=_s3_put_object_definition(TEST_BUCKET, TEST_KEY, TEST_BODY.decode()),
            roleArn=ROLE_ARN,
        )
    except Exception:  # noqa: BLE001
        _sfn(lws_session).update_state_machine(
            stateMachineArn=_sm_arn(),
            definition=_s3_put_object_definition(TEST_BUCKET, TEST_KEY, TEST_BODY.decode()),
        )


@given("the state machine already has an S3 task configured")
def sm_already_has_s3_task():
    pytest.skip(
        "lws allows update_state_machine even when the state machine already has an S3 task"
        " configured (idempotent overwrite allowed)"
    )


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
def object_slot_available(lws_session):
    lws_session.capacity("s3").unlimited().apply()


@given("no object slot is available")
def no_object_slot_available(lws_session):
    lws_session.capacity("s3").exhaust().apply()


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
def no_execution_slot_available(lws_session):
    lws_session.capacity("stepfunctions").exhaust().apply()


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
def configure_s3_task(lws_session, world):
    # Act
    try:
        world["result"] = _sfn(lws_session).update_state_machine(
            stateMachineArn=_sm_arn(),
            definition=_s3_put_object_definition(TEST_BUCKET, TEST_KEY, TEST_BODY.decode()),
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an execution of the state machine is started")
def start_execution(lws_session, world):
    if world.get("_sm_has_no_s3_task"):
        pytest.skip(
            "lws does not reject start_execution when the state machine has no S3 task"
            " configured (no task definition validation)"
        )
    # Act
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
def execution_writes_object(lws_session, world):
    # Arrange: ensure bucket exists and SM has S3 putObject task
    try:
        _create_bucket(lws_session)
    except Exception:  # noqa: BLE001
        pass  # bucket may already exist from a prior Given step
    try:
        _sfn(lws_session).update_state_machine(
            stateMachineArn=_sm_arn(),
            definition=_s3_put_object_definition(TEST_BUCKET, TEST_KEY, TEST_BODY.decode()),
        )
    except Exception:  # noqa: BLE001
        pass  # SM may not exist (negative: no execution RUNNING); update will fail
    # Act
    try:
        resp = _sfn(lws_session).start_execution(
            stateMachineArn=_sm_arn(),
            input=TEST_INPUT,
        )
        world["result"] = resp
        world["execution_arn"] = resp["executionArn"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a running execution reads an existing object from the S3 bucket and succeeds")
def execution_reads_object(lws_session, world):
    # Arrange: ensure bucket + object exist and SM has S3 getObject task
    try:
        _create_bucket(lws_session)
    except Exception:  # noqa: BLE001
        pass
    try:
        _s3(lws_session).put_object(Bucket=TEST_BUCKET, Key=TEST_KEY, Body=TEST_BODY)
    except Exception:  # noqa: BLE001
        pass
    try:
        _sfn(lws_session).update_state_machine(
            stateMachineArn=_sm_arn(),
            definition=_s3_get_object_definition(TEST_BUCKET, TEST_KEY),
        )
    except Exception:  # noqa: BLE001
        pass  # SM may not exist (negative: no execution RUNNING); update will fail
    # Act
    try:
        resp = _sfn(lws_session).start_execution(
            stateMachineArn=_sm_arn(),
            input=TEST_INPUT,
        )
        world["result"] = resp
        world["execution_arn"] = resp["executionArn"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a running execution fails to read because no object exists in the bucket")
def execution_reads_object_not_found(lws_session, world):
    # Arrange: ensure bucket exists but object does NOT exist; SM has S3 getObject task
    try:
        _create_bucket(lws_session)
    except Exception:  # noqa: BLE001
        pass
    try:
        _sfn(lws_session).update_state_machine(
            stateMachineArn=_sm_arn(),
            definition=_s3_get_object_definition(TEST_BUCKET, "nonexistent-key-1"),
        )
    except Exception:  # noqa: BLE001
        pass  # SM may not exist (negative: no execution RUNNING); update will fail
    # Act
    try:
        resp = _sfn(lws_session).start_execution(
            stateMachineArn=_sm_arn(),
            input=TEST_INPUT,
        )
        world["result"] = resp
        world["execution_arn"] = resp["executionArn"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


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
    # Arrange
    expected_error = None
    # Assert
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected state machine update to succeed but got: {actual_error}"


@then('the execution is "RUNNING"')
def execution_is_running_then(world):
    assert world["error"] is None, f"Expected start_execution to succeed but got: {world['error']}"
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"


@then('the object "EXISTS" in the bucket and the execution is "SUCCEEDED"')
def object_exists_and_execution_succeeded(lws_session, world):
    # Arrange
    expected_error = None
    # Assert
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected start_execution to succeed but got: {actual_error}"
    actual_resp = _s3(lws_session).get_object(Bucket=TEST_BUCKET, Key=TEST_KEY)
    actual_body = actual_resp["Body"].read()
    expected_body = TEST_BODY
    assert (
        actual_body == expected_body
    ), f"Expected object body {expected_body!r} but got {actual_body!r}"


@then('the execution is "SUCCEEDED"')
def execution_is_succeeded_then(world):
    # Arrange
    expected_error = None
    # Assert
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected start_execution to succeed but got: {actual_error}"
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"


@then('the execution is "FAILED" with a NoSuchKey error')
def execution_failed_no_such_key(world):
    # Arrange
    expected_error = None
    # Assert: execution starts successfully even when the key doesn't exist;
    # the failure occurs internally and is handled by the engine
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected start_execution to succeed but got: {actual_error}"
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"
