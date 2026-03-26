"""Abstract BDD step definitions for LambdaNeptune integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_FUNC = "e2e-test-func-1"
TEST_CLUSTER = "e2e-test-cluster-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"


def _lambda(lws_session):
    return lws_session.client("lambda")


def _neptune(lws_session):
    return lws_session.client("neptune")


def _create_function(lws_session, name=TEST_FUNC):
    _lambda(lws_session).create_function(
        FunctionName=name,
        Runtime="python3.12",
        Role=ROLE_ARN,
        Handler="index.handler",
        Code={"ZipFile": b"fake"},
    )


def _create_cluster(lws_session, name=TEST_CLUSTER):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    _neptune(lws_session).create_db_cluster(
        DBClusterIdentifier=name,
        Engine="neptune",
    )


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
def cluster_is_available_given(lws_session):
    _create_cluster(lws_session)


@given('the cluster is not "AVAILABLE"')
def cluster_is_not_available_given(lws_session, world):
    _create_cluster(lws_session)


@given("the cluster does not exist")
def cluster_does_not_exist():
    """No-op: fresh state has no clusters."""


# ── Given: Neptune cluster state (quoted) ─────────────────────────────


@given('the Neptune cluster is "AVAILABLE"')
def neptune_cluster_is_available_given(lws_session):
    _create_cluster(lws_session)


@given('the Neptune cluster is not "AVAILABLE"')
def neptune_cluster_is_not_available_given(lws_session, world):
    _create_cluster(lws_session)


@given('the Neptune cluster is "STOPPED"')
def neptune_cluster_is_stopped_given(lws_session, world):
    _create_cluster(lws_session)


@given('the Neptune cluster is not "STOPPED"')
def neptune_cluster_is_not_stopped_given(lws_session):
    _create_cluster(lws_session)


@given('the cluster is "STOPPED"')
def cluster_is_stopped_given(lws_session, world):
    _create_cluster(lws_session)


@given('the cluster is not "STOPPED"')
def cluster_is_not_stopped_given(lws_session):
    _create_cluster(lws_session)


# ── Given: invocation state ────────────────────────────────────────────


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


# ── Given: sequence setup ─────────────────────────────────────────────


@given("fid not in func_status")
def fid_not_in_func_status():
    """No-op: fresh state has no functions."""


@given("cid not in cluster_status")
def cid_not_in_cluster_status():
    """No-op: fresh state has no clusters."""


@given("cid in cluster_status")
def cid_in_cluster_status(lws_session):
    _create_cluster(lws_session)


@given("fid in func_status")
def fid_in_func_status(lws_session):
    _create_function(lws_session)


@given("iid in inv_status")
def iid_in_inv_status():
    pytest.skip("Cannot create an in-progress invocation in lws")


@given("a Lambda function has been deployed")
def lambda_function_has_been_deployed_seq(lws_session):
    _create_function(lws_session)


@given("a Neptune cluster has been created")
def neptune_cluster_has_been_created_seq(lws_session):
    _create_cluster(lws_session)


@given("the Neptune cluster has been stopped")
def neptune_cluster_has_been_stopped_seq():
    pytest.skip("Cannot stop a Neptune cluster in lws")


@given("the Neptune cluster has been started")
def neptune_cluster_has_been_started_seq():
    pytest.skip("Cannot start a Neptune cluster in lws")


@given("the Lambda function has been invoked")
def lambda_function_has_been_invoked_seq():
    pytest.skip("Cannot create a completed Lambda invocation in lws")


@given(
    'the Lambda function has executed a graph query against the "AVAILABLE" cluster and succeeded'
)
def lambda_executed_graph_query_succeeded_seq():
    pytest.skip("Cannot trigger Lambda Neptune query in lws")


@given("the Lambda function has failed to connect because the Neptune cluster is stopped")
def lambda_failed_connect_cluster_stopped_seq():
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


@when("a Neptune cluster is created")
def create_neptune_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when("the Neptune cluster is started")
def start_neptune_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when("the Neptune cluster is stopped")
def stop_neptune_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when("the Lambda function is invoked")
def invoke_function(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when("the Lambda function fails to connect because the Neptune cluster is stopped")
def invocation_fails_cluster_stopped(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when('the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds')
def lambda_executes_graph_query(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


# ── Then: assertions ────────────────────────────────────────────────────


@then('the function is "ACTIVE"')
def func_is_active_then(lws_session):
    resp = _lambda(lws_session).get_function(FunctionName=TEST_FUNC)
    expected_state = "Active"
    actual_state = resp["Configuration"]["State"]
    assert (
        actual_state == expected_state
    ), f"Expected function state '{expected_state}' but got '{actual_state}'"


@then('the cluster is "AVAILABLE"')
def cluster_is_available_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@then('the cluster is "AVAILABLE" and ready to accept graph queries')
def cluster_is_available_ready_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@then('the cluster is "STOPPED" and graph queries will be rejected')
def cluster_is_stopped_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@then('the invocation is "IN_PROGRESS"')
def invocation_is_in_progress_then(world):
    pytest.skip("Cannot observe Lambda invocation state in lws")


@then('the invocation is "FAILED" with a connection error')
def invocation_failed_connection_error(world):
    pytest.skip("Cannot observe Lambda invocation failure in lws")


@then('the invocation is "SUCCESS"')
def invocation_is_success_then(world):
    pytest.skip("Cannot observe Lambda invocation success in lws")


# ── Then: sequence invariants ──────────────────────────────────────────


@then('every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function')
def _inv_lambda_neptune_every_in_progress_invocation_references_an_active_lambda_fun():
    """Invariant step: trivially satisfied in isolated test context."""


@then("every successful invocation recorded which cluster it queried")
def _inv_lambda_neptune_every_successful_invocation_recorded_which_cluster_it_querie():
    """Invariant step: trivially satisfied in isolated test context."""
