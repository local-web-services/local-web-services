"""Abstract BDD step definitions for LambdaMemorydb integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_FUNC = "e2e-test-func-1"
TEST_CLUSTER = "e2e-test-cluster-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"


def _lambda(lws_session):
    return lws_session.client("lambda")


def _memorydb(lws_session):
    return lws_session.client("memorydb")


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
    _memorydb(lws_session).create_cluster(
        ClusterName=name,
        NodeType="db.t4g.small",
        ACLName="open-access",
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


@given('the cluster is "UPDATING"')
def cluster_is_updating_given(lws_session, world):
    _create_cluster(lws_session)


@given('the cluster is not "UPDATING"')
def cluster_is_not_updating_given(lws_session):
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


@given("a record slot is available")
def record_slot_available():
    """No-op: always room for records."""


@given("no record slot is available")
def no_record_slot_available():
    pytest.skip("Cannot exhaust record slot limit")


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


@when("a MemoryDB cluster is created")
def create_memorydb_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when("a MemoryDB cluster update begins")
def memorydb_cluster_update_begins(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when("the MemoryDB cluster update completes")
def memorydb_cluster_update_completes(world):
    pytest.skip("Cannot trigger MemoryDB cluster update completion in lws")


@when("the Lambda function is invoked")
def invoke_function(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when("the Lambda function fails to write because the cluster is updating")
def invocation_fails_cluster_updating(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when('the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation')
def lambda_writes_record(world):
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


@then('the cluster is "UPDATING" and write operations may fail')
def cluster_is_updating_then(world):
    pytest.skip("Cannot observe MemoryDB cluster updating state in lws")


@then('the cluster is "AVAILABLE" again')
def cluster_is_available_again_then(world):
    pytest.skip("Cannot observe MemoryDB cluster update completion in lws")


@then('the invocation is "IN_PROGRESS"')
def invocation_is_in_progress_then(world):
    pytest.skip("Cannot observe Lambda invocation state in lws")


@then('the invocation is "FAILED" with a connection refused error')
def invocation_failed_connection_refused(world):
    pytest.skip("Cannot observe Lambda invocation failure in lws")


@then('the record "EXISTS" in the cluster and the invocation is "SUCCESS"')
def record_exists_invocation_success(world):
    pytest.skip("Cannot observe Lambda record write result in lws")
