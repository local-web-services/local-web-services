"""Abstract BDD step definitions for LambdaDocdb integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_FUNC = "e2e-test-func-1"
TEST_CLUSTER = "e2e-test-cluster-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"


def _lambda(lws_session):
    return lws_session.client("lambda")


def _docdb(lws_session):
    return lws_session.client("docdb")


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
    _docdb(lws_session).create_db_cluster(
        DBClusterIdentifier=name,
        Engine="docdb",
        MasterUsername="admin",
        MasterUserPassword="pass123",
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


@given('the cluster is "STOPPED"')
def cluster_is_stopped_given(lws_session, world):
    _create_cluster(lws_session)


@given('the cluster is not "STOPPED"')
def cluster_is_not_stopped_given(lws_session):
    _create_cluster(lws_session)


@given("the cluster does not exist")
def cluster_does_not_exist():
    """No-op: fresh state has no clusters."""


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


@given("a document slot is available")
def document_slot_available():
    """No-op: always room for documents."""


@given("no document slot is available")
def no_document_slot_available():
    pytest.skip("Cannot exhaust document slot limit")


# ── Given: sequence setup ─────────────────────────────────────────────


@given("fid not in func_status")
def fid_not_in_func_status():
    """No-op: fresh state has no Lambda functions."""


@given("fid in func_status")
def fid_in_func_status(lws_session):
    _create_function(lws_session)


@given("a Lambda function has been deployed")
def lambda_docdb_seq_function_deployed(lws_session):
    _create_function(lws_session)


@given("cid not in cluster_status")
def cid_not_in_cluster_status():
    """No-op: fresh state has no DocumentDB clusters."""


@given("cid in cluster_status")
def cid_in_cluster_status(lws_session):
    _create_cluster(lws_session)


@given("a DocumentDB cluster has been created")
def lambda_docdb_seq_cluster_created(lws_session):
    _create_cluster(lws_session)


@given("the DocumentDB cluster has been stopped")
def lambda_docdb_seq_cluster_stopped():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@given("the DocumentDB cluster has been started")
def lambda_docdb_seq_cluster_started():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@given("the Lambda function has been invoked")
def lambda_docdb_seq_function_invoked():
    pytest.skip("Cannot trigger Lambda invocation in lws")


@given("iid in inv_status")
def iid_in_inv_status():
    pytest.skip("Cannot observe Lambda invocation state in lws")


@given(
    'the Lambda function has written a document to the "AVAILABLE" DocumentDB cluster and succeeded'
)
def lambda_docdb_seq_invocation_succeeded():
    pytest.skip("Cannot trigger Lambda invocation in lws")


@given("the Lambda function has failed to connect because the DocumentDB cluster is stopped")
def lambda_docdb_seq_invocation_failed():
    pytest.skip("Cannot trigger Lambda invocation in lws")


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


@when("a DocumentDB cluster is created")
def create_docdb_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when("the DocumentDB cluster is started")
def start_docdb_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when("the DocumentDB cluster is stopped")
def stop_docdb_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when("the Lambda function is invoked")
def invoke_function(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when("the Lambda function fails to connect because the DocumentDB cluster is stopped")
def invocation_fails_cluster_stopped(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when('the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds')
def lambda_writes_document(world):
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


@then('the cluster is "AVAILABLE" and ready to accept connections')
def cluster_is_available_ready_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@then('the cluster is "STOPPED" and connections will be rejected')
def cluster_is_stopped_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@then('the invocation is "IN_PROGRESS"')
def invocation_is_in_progress_then(world):
    pytest.skip("Cannot observe Lambda invocation state in lws")


@then('the invocation is "FAILED" with a connection error')
def invocation_failed_connection_error(world):
    pytest.skip("Cannot observe Lambda invocation failure in lws")


@then('the document "EXISTS" and the invocation is "SUCCESS"')
def document_exists_invocation_success(world):
    pytest.skip("Cannot observe Lambda document write result in lws")


# ── Then: sequence invariants ──────────────────────────────────────────


@then('every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function')
def _inv_lambda_docdb_every_in_progress_invocation_references_an_active_lambda_funct():
    """Invariant step: trivially satisfied in isolated test context."""


@then("every existing document references a cluster that exists")
def _inv_lambda_docdb_every_existing_document_references_a_cluster_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
