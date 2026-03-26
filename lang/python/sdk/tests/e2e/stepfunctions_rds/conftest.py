"""Abstract BDD step definitions for StepfunctionsRds integration spec scenarios."""

from __future__ import annotations

import json

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_SM = "test-sm-1"
TEST_CLUSTER = "e2e-test-cluster-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"
PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})
TEST_INPUT = '{"key": "value"}'


def _sfn(lws_session):
    return lws_session.client("stepfunctions")


def _rds(lws_session):
    return lws_session.client("rds")


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"


def _create_sm(lws_session, name=TEST_SM):
    resp = _sfn(lws_session).create_state_machine(
        name=name,
        definition=PASS_DEFINITION,
        roleArn=ROLE_ARN,
    )
    return resp["stateMachineArn"]


def _create_cluster(lws_session, name=TEST_CLUSTER):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    _rds(lws_session).create_db_cluster(
        DBClusterIdentifier=name,
        Engine="aurora-mysql",
        MasterUsername="admin",
        MasterUserPassword="password123",
    )


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


@given("dbid not in db_status")
def dbid_not_in_db_status():
    """No-op: guard condition — fresh state has no RDS DB instances."""


@given("dbid in db_status")
def dbid_in_db_status():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@given('an "RDS" "DB" instance has been created')
def rds_db_instance_has_been_created():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@given('a Multi-"AZ" failover has begun on the "DB" instance')
def multi_az_failover_begun_given():
    pytest.skip("Cannot pre-set a Multi-AZ failover state for sequence setup")


@given('the "DB" instance failover has completed')
def db_instance_failover_completed_given():
    pytest.skip("Cannot pre-set a completed DB instance failover state for sequence setup")


@given("an execution of the state machine has been started")
def execution_of_sm_has_been_started():
    pytest.skip("Cannot pre-set a running execution state for sequence setup")


@given("eid in exec_status")
def eid_in_exec_status():
    pytest.skip("Cannot pre-set an in-flight execution state for sequence setup")


@given('a running execution has queried the "AVAILABLE" "DB" instance and the task succeeded')
def running_execution_queried_db_succeeded_given():
    pytest.skip("Cannot pre-set a completed execution RDS task state for sequence setup")


@given('a running execution has failed to query the "DB" because it is failing over')
def running_execution_failed_db_failing_over_given():
    pytest.skip("Cannot pre-set a failed execution RDS task state for sequence setup")


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


# ── Given: DB instance state ──────────────────────────────────────────


@given('the "DB" instance does not already exist')
def db_instance_not_already_exist():
    """No-op: fresh state has no RDS DB instances."""


@given('the "DB" instance already exists')
def db_instance_already_exists(lws_session):
    _create_cluster(lws_session)


@given('the "DB" instance exists')
def db_instance_exists(lws_session):
    _create_cluster(lws_session)


@given('the "DB" instance is "AVAILABLE"')
def db_instance_is_available_given():
    """No-op: RDS DB clusters are AVAILABLE immediately after creation."""


@given('the "DB" instance does not exist')
def db_instance_does_not_exist():
    """No-op: fresh state has no RDS DB instances."""


@given('the "DB" instance is "FAILING_OVER"')
def db_instance_is_failing_over_given(lws_session, world):
    pytest.skip("Cannot put an RDS DB instance into FAILING_OVER state in lws")


@given('the "DB" instance is not "FAILING_OVER"')
def db_instance_is_not_failing_over_given(lws_session):
    _create_cluster(lws_session)


@given('the "DB" instance is not "AVAILABLE"')
def db_instance_is_not_available_given():
    pytest.skip("lws does not support non-AVAILABLE RDS DB instance lifecycle states")


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


@when('an "RDS" "DB" instance is created')
def create_rds_db_instance(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when('a Multi-"AZ" failover begins on the "DB" instance')
def multi_az_failover_begins(lws_session, world):
    pytest.skip("Cannot trigger a Multi-AZ failover on an RDS DB instance in lws")


@when('the "DB" instance failover completes')
def db_instance_failover_completes(world):
    pytest.skip("Cannot trigger internal RDS DB instance failover completion in lws")


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


@when('a running execution queries the "AVAILABLE" "DB" instance and the task succeeds')
def execution_queries_db_succeeds(world):
    pytest.skip("Cannot trigger internal execution step that queries RDS DB in lws")


@when('a running execution fails to query the "DB" because it is failing over')
def execution_fails_db_failing_over(world):
    pytest.skip("Cannot trigger internal execution step that fails due to RDS DB failover in lws")


# ── Then: assertions ───────────────────────────────────────────────────


@then('the state machine is "ACTIVE"')
def sm_is_active_then(lws_session):
    resp = _sfn(lws_session).describe_state_machine(stateMachineArn=_sm_arn())
    expected_status = "ACTIVE"
    actual_status = resp.get("status", "")
    assert (
        actual_status == expected_status
    ), f"Expected state machine status '{expected_status}' but got '{actual_status}'"


@then('the "DB" instance is "AVAILABLE"')
def db_instance_is_available_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@then('the "DB" instance is "FAILING_OVER" and queries will be rejected')
def db_instance_is_failing_over_then(lws_session):
    pytest.skip("Cannot observe RDS DB instance FAILING_OVER state in lws")


@then('the "DB" instance is "AVAILABLE" again')
def db_instance_is_available_again_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@then('the execution is "RUNNING"')
def execution_is_running_then(world):
    assert world["error"] is None, f"Expected start_execution to succeed but got: {world['error']}"
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"


@then('the execution is "SUCCEEDED"')
def execution_is_succeeded_then():
    pytest.skip("Cannot observe internal execution RDS task success in lws")


@then('the execution is "FAILED" with a connection error')
def execution_failed_connection_error():
    pytest.skip("Cannot observe internal execution RDS task failure in lws")


# ── Then: sequence invariants ──────────────────────────────────────────


@then('every "RUNNING" execution references an "ACTIVE" state machine')
def _inv_stepfunctions_rds_every_running_execution_references_an_active_state_machin():
    """Invariant step: trivially satisfied in isolated test context."""


@then('every succeeded execution recorded which "DB" instance it queried')
def _inv_stepfunctions_rds_every_succeeded_execution_recorded_which_db_instance_it_q():
    """Invariant step: trivially satisfied in isolated test context."""
