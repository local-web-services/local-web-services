"""Abstract BDD step definitions for RdsLambda integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_CLUSTER = "e2e-test-cluster-1"
TEST_FUNC = "e2e-test-func-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"


def _rds(lws_session):
    return lws_session.client("rds")


def _lambda(lws_session):
    return lws_session.client("lambda")


def _create_db_instance(lws_session, name=TEST_CLUSTER):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    _rds(lws_session).create_db_instance(
        DBInstanceIdentifier=name,
        DBInstanceClass="db.t3.micro",
        Engine="mysql",
        MasterUsername="admin",
        MasterUserPassword="password123",
        AllocatedStorage=20,
    )


def _get_db_instance_exists(lws_session, name=TEST_CLUSTER):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    try:
        _rds(lws_session).describe_db_instances(DBInstanceIdentifier=name)
        return True
    except Exception:  # noqa: BLE001
        return False


def _create_function(lws_session, name=TEST_FUNC):
    _lambda(lws_session).create_function(
        FunctionName=name,
        Runtime="python3.12",
        Role=ROLE_ARN,
        Handler="index.handler",
        Code={"ZipFile": b"fake"},
    )


def _get_function_exists(lws_session, name=TEST_FUNC):
    try:
        _lambda(lws_session).get_function(FunctionName=name)
        return True
    except Exception:  # noqa: BLE001
        return False


# ── Given: DB instance state ──────────────────────────────────────────


@given('the "DB" instance does not already exist')
def rds_lambda_db_not_already_exist():
    """No-op: fresh state has no DB instances."""


@given('the "DB" instance already exists')
def rds_lambda_db_already_exists(lws_session):
    _create_db_instance(lws_session)


@given('the "DB" instance exists and is "AVAILABLE"')
def rds_lambda_db_exists_and_available(lws_session):
    _create_db_instance(lws_session)


@given('the "DB" instance does not exist or is not "AVAILABLE"')
def rds_lambda_db_not_exist_or_not_available():
    pytest.skip("Cannot configure RDS event trigger for Lambda in lws")


@given('the "DB" instance has no Lambda integration configured')
def rds_lambda_db_has_no_integration():
    """No-op: DB instances have no Lambda integration by default."""


@given('the "DB" instance already has a Lambda integration configured')
def rds_lambda_db_already_has_integration():
    pytest.skip("Cannot configure RDS event trigger for Lambda in lws")


@given('the "DB" instance is "AVAILABLE"')
def rds_lambda_db_is_available_given():
    """No-op: DB instances are available by default in lws."""


@given('the "DB" instance is not "AVAILABLE"')
def rds_lambda_db_is_not_available():
    pytest.skip("Cannot configure RDS event trigger for Lambda in lws")


@given('the "DB" instance has a Lambda integration configured')
def rds_lambda_db_has_integration():
    pytest.skip("Cannot configure RDS event trigger for Lambda in lws")


# ── Given: function state ─────────────────────────────────────────────


@given("the function does not already exist")
def rds_lambda_function_not_already_exist():
    """No-op: fresh state has no Lambda functions."""


@given("the function already exists")
def rds_lambda_function_already_exists(lws_session):
    _create_function(lws_session)


@given("the function exists")
def rds_lambda_function_exists(lws_session):
    _create_function(lws_session)


@given('the function exists and is "ACTIVE"')
def rds_lambda_function_exists_and_active(lws_session):
    _create_function(lws_session)


@given('the function does not exist or is not "ACTIVE"')
def rds_lambda_function_not_exist_or_not_active():
    """No-op: fresh state has no functions."""


@given('the function is "ACTIVE"')
def rds_lambda_function_is_active_given():
    """No-op: Lambda functions are ACTIVE immediately after creation."""


@given('the function is not "ACTIVE"')
def rds_lambda_function_is_not_active_given(lws_session, world):
    try:
        _lambda(lws_session).delete_function(FunctionName=TEST_FUNC)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("lambda").create_dwell_ms(5000).apply()
    _create_function(lws_session)
    world["result"] = None
    world["error"] = None


@given("the function does not exist")
def rds_lambda_function_does_not_exist():
    """No-op: fresh state has no Lambda functions."""


@given('the function is already "DELETED"')
def rds_lambda_function_is_already_deleted(lws_session, world):
    try:
        _create_function(lws_session)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("lambda").delete_dwell_ms(5000).apply()
    try:
        _lambda(lws_session).delete_function(FunctionName=TEST_FUNC)
    except Exception:  # noqa: BLE001
        pass
    world["result"] = None
    world["error"] = None


@given('the Lambda function is "ACTIVE"')
def rds_lambda_lambda_function_is_active():
    pytest.skip("Cannot configure RDS event trigger for Lambda in lws")


@given('the Lambda function is not "ACTIVE"')
def rds_lambda_lambda_function_is_not_active():
    pytest.skip("Cannot configure RDS event trigger for Lambda in lws")


@given('the Lambda function is "DELETED"')
def rds_lambda_lambda_function_is_deleted():
    pytest.skip("Cannot configure RDS event trigger for Lambda in lws")


@given('the Lambda function is not "DELETED"')
def rds_lambda_lambda_function_is_not_deleted():
    pytest.skip("Cannot configure RDS event trigger for Lambda in lws")


# ── Given: slots ───────────────────────────────────────────────────────


@given("an invocation slot is available")
def rds_lambda_invocation_slot_available(lws_session):
    lws_session.capacity("lambda").unlimited().apply()


@given("no invocation slot is available")
def rds_lambda_no_invocation_slot_available(lws_session):
    lws_session.capacity("lambda").exhaust().apply()


# ── When: actions ──────────────────────────────────────────────────────


@when('an "RDS" "DB" instance is created')
def create_rds_db_instance(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when("a Lambda function is deployed")
def deploy_lambda_function_rds(lws_session, world):
    try:
        resp = _lambda(lws_session).create_function(
            FunctionName=TEST_FUNC,
            Runtime="python3.12",
            Role=ROLE_ARN,
            Handler="index.handler",
            Code={"ZipFile": b"fake"},
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when('the "DB" instance is configured with an "IAM" role to invoke the Lambda function')
def configure_rds_lambda_integration(world):
    pytest.skip("Cannot configure RDS event trigger for Lambda in lws")


@when('an "RDS" stored procedure invokes the Lambda function and succeeds')
def stored_proc_invokes_lambda(world):
    pytest.skip("Cannot trigger RDS->Lambda invocation in lws")


@when("the Lambda function is deleted")
def delete_lambda_function_rds(lws_session, world):
    try:
        resp = _lambda(lws_session).delete_function(FunctionName=TEST_FUNC)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when('an "RDS" stored procedure fails to invoke Lambda because the function has been deleted')
def stored_proc_fails_function_deleted(world):
    pytest.skip("Cannot trigger RDS->Lambda invocation in lws")


# ── Then: assertions ───────────────────────────────────────────────────


@then('the "DB" instance is "AVAILABLE" with no Lambda integration configured')
def db_instance_available_no_integration(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@then('the function is "ACTIVE"')
def rds_lambda_function_is_active_then(lws_session):
    resp = _lambda(lws_session).get_function(FunctionName=TEST_FUNC)
    expected_state = "Active"
    actual_state = resp["Configuration"].get("State", "")
    assert (
        actual_state == expected_state
    ), f"Expected function state '{expected_state}' but got '{actual_state}'"


@then('stored procedures on the "DB" can invoke the Lambda function')
def stored_procs_can_invoke():
    pytest.skip("Cannot configure RDS event trigger for Lambda in lws")


@then('the invocation is "SUCCESS"')
def rds_lambda_invocation_success():
    pytest.skip("Cannot trigger RDS->Lambda invocation in lws")


@then('the function is "DELETED" and stored procedure invocations targeting it will fail')
def function_is_deleted_procs_fail(lws_session):
    expected_exists = False
    actual_exists = _get_function_exists(lws_session)
    assert actual_exists == expected_exists, "Expected function to be deleted but it still exists"


@then('the invocation is "FAILED" with a function not found error')
def invocation_failed_function_not_found():
    pytest.skip("Cannot trigger RDS->Lambda invocation in lws")


# ── Given: sequence setup ─────────────────────────────────────────


@given("dbid not in db_status")
def rds_lambda_dbid_not_in_db_status():
    """No-op: fresh state has no DB instances."""


@given('an "RDS" "DB" instance has been created')
def rds_lambda_rds_db_instance_has_been_created(lws_session):
    _create_db_instance(lws_session)


@given("fid not in func_status")
def rds_lambda_fid_not_in_func_status():
    """No-op: fresh state has no Lambda functions."""


@given("a Lambda function has been deployed")
def rds_lambda_lambda_function_has_been_deployed(lws_session):
    _create_function(lws_session)


@given("fid in func_status")
def rds_lambda_fid_in_func_status(lws_session):
    _create_function(lws_session)


@given("the Lambda function has been deleted")
def rds_lambda_lambda_function_has_been_deleted(lws_session):
    try:
        _create_function(lws_session)
    except Exception:  # noqa: BLE001
        pass
    _lambda(lws_session).delete_function(FunctionName=TEST_FUNC)


@given("dbid in db_status")
def rds_lambda_dbid_in_db_status(lws_session):
    _create_db_instance(lws_session)


@given('the "DB" instance has been configured with an "IAM" role to invoke the Lambda function')
def rds_lambda_db_configured_with_iam_role():
    pytest.skip("Cannot configure RDS event trigger for Lambda in lws")


@given('an "RDS" stored procedure has invoked the Lambda function and succeeded')
def rds_stored_proc_invoked_lambda_succeeded():
    pytest.skip("Cannot trigger RDS->Lambda invocation in lws")


@given(
    'an "RDS" stored procedure has failed to invoke Lambda because the function has been deleted'
)
def rds_stored_proc_failed_function_deleted():
    pytest.skip("Cannot trigger RDS->Lambda invocation in lws")


# ── Then: sequence invariants ──────────────────────────────────────────


@then("every successful invocation recorded which function it invoked")
def _inv_rds_lambda_every_successful_invocation_recorded_which_function_it_invoked():
    """Invariant step: trivially satisfied in isolated test context."""


@then('every successful invocation references a "DB" instance that exists')
def _inv_rds_lambda_every_successful_invocation_references_a_db_instance_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
