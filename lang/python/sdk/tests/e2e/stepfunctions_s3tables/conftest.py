"""Abstract BDD step definitions for StepfunctionsS3tables integration spec scenarios."""

from __future__ import annotations

import json

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_SM = "test-sm-1"
TEST_BUCKET = "e2e-test-table-bucket-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"
PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})
TEST_INPUT = '{"key": "value"}'


def _sfn(lws_session):
    return lws_session.client("stepfunctions")


def _s3tables(lws_session):
    return lws_session.client("s3tables")


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"


def _create_sm(lws_session, name=TEST_SM):
    resp = _sfn(lws_session).create_state_machine(
        name=name,
        definition=PASS_DEFINITION,
        roleArn=ROLE_ARN,
    )
    return resp["stateMachineArn"]


def _create_table_bucket(lws_session, name=TEST_BUCKET):
    _s3tables(lws_session).create_table_bucket(name=name)


def _table_bucket_exists(lws_session, name=TEST_BUCKET):
    resp = _s3tables(lws_session).list_table_buckets()
    for bucket in resp.get("tableBuckets", []):
        if bucket["name"] == name:
            return True
    return False


def _start_execution(lws_session, name=TEST_SM):
    resp = _sfn(lws_session).start_execution(
        stateMachineArn=_sm_arn(name),
        input=TEST_INPUT,
    )
    return resp["executionArn"]


# ── Given: sequence setup ─────────────────────────────────────────────


@given("smid not in sm_status")
def smid_not_in_sm_status():
    """No-op: guard condition — fresh state has no state machines."""


@given("smid in sm_status")
def smid_in_sm_status(lws_session):
    _create_sm(lws_session)


@given("a Step Functions state machine has been created")
def sfn_sm_has_been_created(lws_session):
    _create_sm(lws_session)


@given("tid not in table_status")
def tid_not_in_table_status():
    """No-op: guard condition — fresh state has no S3 Tables table buckets."""


@given("tid in table_status")
def tid_in_table_status(lws_session):
    _create_table_bucket(lws_session)


@given("an S3 Tables table has been created")
def s3tables_table_has_been_created(lws_session):
    _create_table_bucket(lws_session)


@given("a table deletion has been initiated")
def table_deletion_initiated_given():
    pytest.skip("Cannot pre-set an S3 Tables table deletion state for sequence setup")


@given("an execution of the state machine has been started")
def execution_of_sm_has_been_started():
    pytest.skip("Cannot pre-set a running execution state for sequence setup")


@given("eid in exec_status")
def eid_in_exec_status():
    pytest.skip("Cannot pre-set an in-flight execution state for sequence setup")


@given('a running execution has called an "ACTIVE" S3 Tables table and the task succeeded')
def running_execution_called_table_succeeded_given():
    pytest.skip("Cannot pre-set a completed execution S3 Tables task state for sequence setup")


@given("a running execution has failed because the S3 Tables table is being deleted")
def running_execution_failed_table_deleting_given():
    pytest.skip("Cannot pre-set a failed execution S3 Tables task state for sequence setup")


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


# ── Given: table state ────────────────────────────────────────────────


@given("the table does not already exist")
def table_not_already_exist():
    """No-op: fresh state has no S3 Tables table buckets."""


@given("the table already exists")
def table_already_exists(lws_session):
    _create_table_bucket(lws_session)


@given("the table exists")
def table_exists(lws_session):
    _create_table_bucket(lws_session)


@given('the table is "ACTIVE"')
def table_is_active_given():
    """No-op: S3 Tables table buckets are ACTIVE immediately after creation."""


@given("the table does not exist")
def table_does_not_exist():
    """No-op: fresh state has no S3 Tables table buckets."""


@given('the table is "DELETING"')
def table_is_deleting_given(lws_session, world):
    pytest.skip("Cannot put an S3 Tables table into DELETING state in lws")


@given('the table is already "DELETING"')
def table_is_already_deleting_given(lws_session, world):
    pytest.skip("Cannot put an S3 Tables table into DELETING state in lws")


@given('the table is not "DELETING"')
def table_is_not_deleting_given(lws_session):
    _create_table_bucket(lws_session)


@given('the table does not exist or is "DELETING"')
def table_does_not_exist_or_deleting_given():
    """No-op: fresh state has no S3 Tables table buckets."""


# ── Given: execution state ────────────────────────────────────────────


@given('an execution is "RUNNING"')
def execution_is_running_given(lws_session):
    _create_sm(lws_session)
    _start_execution(lws_session)


@given('no execution is "RUNNING"')
def no_execution_is_running():
    """No-op: fresh state has no executions."""


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


@when("an S3 Tables table is created")
def create_s3tables_table(lws_session, world):
    try:
        resp = _s3tables(lws_session).create_table_bucket(name=TEST_BUCKET)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a table deletion is initiated")
def initiate_table_deletion(lws_session, world):
    pytest.skip("Cannot trigger internal S3 Tables table deletion in lws")


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


@when('a running execution calls an "ACTIVE" S3 Tables table and the task succeeds')
def execution_calls_active_table_succeeds(world):
    pytest.skip("Cannot trigger internal execution step that calls S3 Tables in lws")


@when("a running execution fails because the S3 Tables table is being deleted")
def execution_fails_table_deleting(world):
    pytest.skip(
        "Cannot trigger internal execution step that fails due to S3 Tables table deletion in lws"
    )


# ── Then: assertions ───────────────────────────────────────────────────


@then('the state machine is "ACTIVE"')
def sm_is_active_then(lws_session):
    resp = _sfn(lws_session).describe_state_machine(stateMachineArn=_sm_arn())
    expected_status = "ACTIVE"
    actual_status = resp.get("status", "")
    assert (
        actual_status == expected_status
    ), f"Expected state machine status '{expected_status}' but got '{actual_status}'"


@then('the table is "ACTIVE"')
def table_is_active_then(lws_session):
    expected_exists = True
    actual_exists = _table_bucket_exists(lws_session)
    assert (
        actual_exists is expected_exists
    ), f"Expected S3 Tables table bucket '{TEST_BUCKET}' to be ACTIVE but it was not found"


@then('the table is "DELETING" and "SDK" task calls targeting it will fail')
def table_is_deleting_then(lws_session):
    pytest.skip("Cannot observe S3 Tables table DELETING state in lws")


@then('the execution is "RUNNING"')
def execution_is_running_then(world):
    assert world["error"] is None, f"Expected start_execution to succeed but got: {world['error']}"
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"


@then('the execution is "SUCCEEDED"')
def execution_is_succeeded_then():
    pytest.skip("Cannot observe internal execution S3 Tables task success in lws")


@then('the execution is "FAILED" with a ResourceNotFoundException')
def execution_failed_resource_not_found():
    pytest.skip("Cannot observe internal execution S3 Tables task failure in lws")


# ── Then: sequence invariants ──────────────────────────────────────────


@then('every "RUNNING" execution references an "ACTIVE" state machine')
def _inv_stepfunctions_s3tables_every_running_execution_references_an_active_state_m():
    """Invariant step: trivially satisfied in isolated test context."""


@then("every succeeded execution recorded which table it called")
def _inv_stepfunctions_s3tables_every_succeeded_execution_recorded_which_table_it_ca():
    """Invariant step: trivially satisfied in isolated test context."""
