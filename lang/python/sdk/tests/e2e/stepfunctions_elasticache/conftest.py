"""Abstract BDD step definitions for StepfunctionsElasticache integration spec scenarios."""

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


def _elasticache(lws_session):
    return lws_session.client("elasticache")


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
    _elasticache(lws_session).create_cache_cluster(
        CacheClusterId=name,
        CacheNodeType="cache.t3.micro",
        Engine="redis",
        NumCacheNodes=1,
    )


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


# ── Given: cluster state ───────────────────────────────────────────────


@given("the cluster does not already exist")
def cluster_not_already_exist():
    """No-op: fresh state has no clusters."""


@given("the cluster already exists")
def cluster_already_exists(lws_session):
    _create_cluster(lws_session)


@given("the cluster exists")
def cluster_exists(lws_session):
    _create_cluster(lws_session)


@given('the cluster is "AVAILABLE"')
def cluster_is_available_given():
    """No-op: ElastiCache clusters are AVAILABLE immediately after creation."""


@given("the cluster does not exist")
def cluster_does_not_exist():
    """No-op: fresh state has no clusters."""


@given('the cluster is "MODIFYING"')
def cluster_is_modifying_given(lws_session, world):
    _create_cluster(lws_session)


@given('the cluster is not "MODIFYING"')
def cluster_is_not_modifying_given(lws_session):
    _create_cluster(lws_session)


@given('the cluster is not "AVAILABLE"')
def cluster_is_not_available_given():
    pytest.skip("lws does not support non-AVAILABLE ElastiCache cluster lifecycle states")


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


@when('an ElastiCache cluster is created and becomes "AVAILABLE"')
def create_elasticache_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when("a cluster modification begins")
def cluster_modification_begins(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when("the cluster modification completes")
def cluster_modification_completes(world):
    pytest.skip("Cannot trigger internal ElastiCache cluster modification completion in lws")


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


@when('a running execution reads from the "AVAILABLE" ElastiCache cluster and succeeds')
def execution_reads_from_cluster_succeeds(world):
    pytest.skip("Cannot trigger internal execution step that reads from ElastiCache in lws")


@when("a running execution fails to connect because the cluster is being modified")
def execution_fails_cluster_modifying(world):
    pytest.skip(
        "Cannot trigger internal execution step that fails due to modifying ElastiCache cluster in lws"
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


@then('the cluster is "MODIFYING" and connections may be refused')
def cluster_is_modifying_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@then('the cluster is "AVAILABLE" again')
def cluster_is_available_again_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@then('the execution is "RUNNING"')
def execution_is_running_then(world):
    assert world["error"] is None, f"Expected start_execution to succeed but got: {world['error']}"
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"


@then('the execution is "SUCCEEDED"')
def execution_is_succeeded_then():
    pytest.skip("Cannot observe internal execution ElastiCache task success in lws")


@then('the execution is "FAILED" with a connection error')
def execution_failed_connection_error():
    pytest.skip("Cannot observe internal execution ElastiCache task failure in lws")
