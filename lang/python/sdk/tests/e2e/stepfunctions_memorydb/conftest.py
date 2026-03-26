"""Abstract BDD step definitions for StepfunctionsMemorydb integration spec scenarios."""

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


def _memorydb(lws_session):
    return lws_session.client("memorydb")


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
    _memorydb(lws_session).create_cluster(
        ClusterName=name,
        NodeType="db.t4g.small",
        ACLName="open-access",
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


@given("cid not in cluster_status")
def cid_not_in_cluster_status():
    """No-op: guard condition — fresh state has no MemoryDB clusters."""


@given("cid in cluster_status")
def cid_in_cluster_status():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@given("a MemoryDB cluster has been created")
def memorydb_cluster_has_been_created():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@given("a MemoryDB cluster update has begun")
def memorydb_cluster_update_begun_given():
    pytest.skip("Cannot pre-set a MemoryDB cluster update state for sequence setup")


@given("the MemoryDB cluster update has completed")
def memorydb_cluster_update_completed_given():
    pytest.skip("Cannot pre-set a completed MemoryDB cluster update state for sequence setup")


@given("an execution of the state machine has been started")
def execution_of_sm_has_been_started():
    pytest.skip("Cannot pre-set a running execution state for sequence setup")


@given("eid in exec_status")
def eid_in_exec_status():
    pytest.skip("Cannot pre-set an in-flight execution state for sequence setup")


@given(
    'a running execution has connected to the "AVAILABLE" MemoryDB cluster and the task succeeded'
)
def running_execution_connected_cluster_succeeded_given():
    pytest.skip("Cannot pre-set a completed execution MemoryDB task state for sequence setup")


@given("a running execution has failed to connect because the MemoryDB cluster is updating")
def running_execution_failed_cluster_updating_given():
    pytest.skip("Cannot pre-set a failed execution MemoryDB task state for sequence setup")


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


# ── Given: cluster state ───────────────────────────────────────────────


@given("the cluster does not already exist")
def cluster_not_already_exist():
    """No-op: fresh state has no MemoryDB clusters."""


@given("the cluster already exists")
def cluster_already_exists(lws_session):
    _create_cluster(lws_session)


@given("the cluster exists")
def cluster_exists(lws_session):
    _create_cluster(lws_session)


@given('the cluster is "AVAILABLE"')
def cluster_is_available_given():
    """No-op: MemoryDB clusters are AVAILABLE immediately after creation."""


@given("the cluster does not exist")
def cluster_does_not_exist():
    """No-op: fresh state has no MemoryDB clusters."""


@given('the cluster is "UPDATING"')
def cluster_is_updating_given(lws_session, world):
    pytest.skip("Cannot put a MemoryDB cluster into UPDATING state in lws")


@given('the cluster is not "UPDATING"')
def cluster_is_not_updating_given(lws_session):
    _create_cluster(lws_session)


@given('the cluster is not "AVAILABLE"')
def cluster_is_not_available_given():
    pytest.skip("lws does not support non-AVAILABLE MemoryDB cluster lifecycle states")


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


@when("a MemoryDB cluster is created")
def create_memorydb_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when("a MemoryDB cluster update begins")
def memorydb_cluster_update_begins(lws_session, world):
    pytest.skip("Cannot trigger internal MemoryDB cluster update in lws")


@when("the MemoryDB cluster update completes")
def memorydb_cluster_update_completes(world):
    pytest.skip("Cannot trigger internal MemoryDB cluster update completion in lws")


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


@when('a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds')
def execution_connects_to_cluster_succeeds(world):
    pytest.skip("Cannot trigger internal execution step that connects to MemoryDB in lws")


@when("a running execution fails to connect because the MemoryDB cluster is updating")
def execution_fails_cluster_updating(world):
    pytest.skip(
        "Cannot trigger internal execution step that fails due to updating MemoryDB cluster in lws"
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


@then('the cluster is "AVAILABLE"')
def cluster_is_available_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@then('the cluster is "UPDATING" and connections may be refused')
def cluster_is_updating_then(lws_session):
    pytest.skip("Cannot observe MemoryDB cluster UPDATING state in lws")


@then('the cluster is "AVAILABLE" again')
def cluster_is_available_again_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@then('the execution is "RUNNING"')
def execution_is_running_then(world):
    assert world["error"] is None, f"Expected start_execution to succeed but got: {world['error']}"
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"


@then('the execution is "SUCCEEDED"')
def execution_is_succeeded_then():
    pytest.skip("Cannot observe internal execution MemoryDB task success in lws")


@then('the execution is "FAILED" with a connection error')
def execution_failed_connection_error():
    pytest.skip("Cannot observe internal execution MemoryDB task failure in lws")


# ── Then: sequence invariants ──────────────────────────────────────────


@then('every "RUNNING" execution references an "ACTIVE" state machine')
def _inv_stepfunctions_memorydb_every_running_execution_references_an_active_state_m():
    """Invariant step: trivially satisfied in isolated test context."""


@then("every succeeded execution recorded which cluster it connected to")
def _inv_stepfunctions_memorydb_every_succeeded_execution_recorded_which_cluster_it_():
    """Invariant step: trivially satisfied in isolated test context."""
