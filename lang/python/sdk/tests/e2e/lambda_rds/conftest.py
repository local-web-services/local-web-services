"""Abstract BDD step definitions for LambdaRds integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_FUNC = "e2e-test-func-1"
TEST_CLUSTER = "e2e-test-cluster-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"


def _lambda(lws_session):
    return lws_session.client("lambda")


def _rds(lws_session):
    return lws_session.client("rds")


def _create_function(lws_session, name=TEST_FUNC):
    _lambda(lws_session).create_function(
        FunctionName=name,
        Runtime="python3.12",
        Role=ROLE_ARN,
        Handler="index.handler",
        Code={"ZipFile": b"fake"},
    )


def _create_db_cluster(lws_session, name=TEST_CLUSTER):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    _rds(lws_session).create_db_cluster(
        DBClusterIdentifier=name,
        Engine="aurora-mysql",
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


# ── Given: DB instance state ───────────────────────────────────────────


@given("the instance does not already exist")
def instance_not_already_exist():
    """No-op: fresh state has no instances."""


@given("the instance already exists")
def instance_already_exists(lws_session):
    _create_db_cluster(lws_session)


@given("the instance exists")
def instance_exists(lws_session):
    _create_db_cluster(lws_session)


@given('the instance is "AVAILABLE"')
def instance_is_available_given(lws_session):
    _create_db_cluster(lws_session)


@given('the instance is not "AVAILABLE"')
def instance_is_not_available_given(lws_session, world):
    _create_db_cluster(lws_session)


@given("the instance does not exist")
def instance_does_not_exist():
    """No-op: fresh state has no instances."""


# ── Given: database instance state (for invocation steps) ─────────────


@given('the database instance is "AVAILABLE"')
def db_instance_is_available_given(lws_session):
    _create_db_cluster(lws_session)


@given('the database instance is not "AVAILABLE"')
def db_instance_is_not_available_given(lws_session, world):
    _create_db_cluster(lws_session)


@given('the database instance is "FAILING_OVER"')
def db_instance_is_failing_over_given(lws_session, world):
    _create_db_cluster(lws_session)


@given('the database instance is not "FAILING_OVER"')
def db_instance_is_not_failing_over_given(lws_session):
    _create_db_cluster(lws_session)


@given('the instance is "FAILING_OVER"')
def instance_is_failing_over_given(lws_session, world):
    _create_db_cluster(lws_session)


@given('the instance is not "FAILING_OVER"')
def instance_is_not_failing_over_given(lws_session):
    _create_db_cluster(lws_session)


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


@when('an "RDS" database instance is created')
def create_rds_instance(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when('a Multi-"AZ" failover begins on the "RDS" instance')
def rds_failover_begins(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when('the Multi-"AZ" failover completes and the new primary is promoted')
def rds_failover_completes(world):
    pytest.skip("Cannot trigger RDS failover completion in lws")


@when("the Lambda function is invoked")
def invoke_function(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when("the Lambda function fails to connect because the database is failing over")
def invocation_fails_db_unavailable(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when('the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds')
def lambda_executes_sql(world):
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


@then('the instance is "AVAILABLE"')
def instance_is_available_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@then('the instance is "FAILING_OVER" and temporarily unavailable for connections')
def instance_is_failing_over_then(world):
    pytest.skip("Cannot observe RDS failover state in lws")


@then('the instance is "AVAILABLE" again')
def instance_is_available_again_then(world):
    pytest.skip("Cannot observe RDS failover completion in lws")


@then('the invocation is "IN_PROGRESS"')
def invocation_is_in_progress_then(world):
    pytest.skip("Cannot observe Lambda invocation state in lws")


@then('the invocation is "FAILED" with a connection error')
def invocation_failed_connection_error(world):
    pytest.skip("Cannot observe Lambda invocation failure in lws")


@then('the invocation is "SUCCESS"')
def invocation_is_success_then(world):
    pytest.skip("Cannot observe Lambda invocation success in lws")
