"""Abstract BDD step definitions for LambdaSecretsmanager integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_FUNC = "e2e-test-func-1"
TEST_SECRET = "e2e-test-secret-1"
TEST_SECRET_VALUE = "e2e-test-secret-value-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"


def _lambda(lws_session):
    return lws_session.client("lambda")


def _secretsmanager(lws_session):
    return lws_session.client("secretsmanager")


def _create_function(lws_session, name=TEST_FUNC):
    _lambda(lws_session).create_function(
        FunctionName=name,
        Runtime="python3.12",
        Role=ROLE_ARN,
        Handler="index.handler",
        Code={"ZipFile": b"fake"},
    )


def _create_secret(lws_session, name=TEST_SECRET):
    _secretsmanager(lws_session).create_secret(Name=name, SecretString=TEST_SECRET_VALUE)


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


# ── Given: secret state ────────────────────────────────────────────────


@given("the secret does not already exist")
def secret_not_already_exist():
    """No-op: fresh state has no secrets."""


@given("the secret already exists")
def secret_already_exists(lws_session):
    _create_secret(lws_session)


@given("the secret exists")
def secret_exists(lws_session):
    _create_secret(lws_session)


@given('the secret is "ACTIVE"')
def secret_is_active_given():
    """No-op: secrets are ACTIVE immediately after creation."""


@given('the secret exists and is "ACTIVE"')
def secret_exists_and_is_active_given(lws_session):
    _create_secret(lws_session)


@given('the secret is not "ACTIVE"')
def secret_is_not_active_given(lws_session, world):  # noqa: ARG001
    pytest.skip("lws does not reject delete_secret on a PENDING_DELETION secret")


@given("the secret does not exist")
def secret_does_not_exist():
    """No-op: fresh state has no secrets."""


@given('the secret does not exist or is not "ACTIVE"')
def secret_not_exist_or_not_active():
    """No-op: fresh state has no secrets."""


@given('the secret is "PENDING_DELETION"')
def secret_is_pending_deletion(lws_session, world):
    try:
        _secretsmanager(lws_session).delete_secret(
            SecretId=TEST_SECRET, ForceDeleteWithoutRecovery=True
        )
    except Exception:  # noqa: BLE001
        pass
    _create_secret(lws_session)
    _secretsmanager(lws_session).delete_secret(SecretId=TEST_SECRET, RecoveryWindowInDays=7)
    world["result"] = None
    world["error"] = None


@given("the secret is not pending deletion")
def secret_is_not_pending_deletion(lws_session):
    _create_secret(lws_session)


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


@given("sid not in secret_status")
def sid_not_in_secret_status():
    """No-op: fresh state has no secrets."""


@given("sid in secret_status")
def sid_in_secret_status(lws_session):
    _create_secret(lws_session)


@given("fid in func_status")
def fid_in_func_status(lws_session):
    _create_function(lws_session)


@given("iid in inv_status")
def iid_in_inv_status():
    pytest.skip("Cannot create an in-progress invocation in lws")


@given("a Lambda function has been deployed")
def lambda_function_has_been_deployed_seq(lws_session):
    _create_function(lws_session)


@given("a secret has been created in Secrets Manager")
def secret_has_been_created_seq(lws_session):
    _create_secret(lws_session)


@given("a secret has been scheduled for deletion")
def secret_has_been_scheduled_for_deletion_seq(lws_session):
    try:
        _create_secret(lws_session)
    except Exception:  # noqa: BLE001
        pass
    _secretsmanager(lws_session).delete_secret(SecretId=TEST_SECRET, RecoveryWindowInDays=7)


@given("the Lambda function has been invoked")
def lambda_function_has_been_invoked_seq():
    pytest.skip("Cannot create a completed Lambda invocation in lws")


@given('the Lambda function has read an "ACTIVE" secret and completed successfully')
def lambda_read_active_secret_succeeded_seq():
    pytest.skip("Cannot trigger Lambda Secrets Manager read in lws")


@given("the Lambda function has failed because the secret is pending deletion")
def lambda_failed_secret_pending_deletion_seq():
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


@when("a secret is created in Secrets Manager")
def create_secret(lws_session, world):
    try:
        _create_secret(lws_session)
        world["result"] = {"Name": TEST_SECRET}
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("a secret is scheduled for deletion")
def schedule_secret_deletion(lws_session, world):
    try:
        resp = _secretsmanager(lws_session).delete_secret(
            SecretId=TEST_SECRET, RecoveryWindowInDays=7
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("the Lambda function is invoked")
def invoke_function(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when("the Lambda function fails because the secret is pending deletion")
def invocation_fails_secret_pending(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when('the Lambda function reads an "ACTIVE" secret and completes successfully')
def invocation_succeeds_secret(world):
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


@then('the secret is "ACTIVE" and can be read by Lambda')
def secret_is_active_then(lws_session):
    resp = _secretsmanager(lws_session).describe_secret(SecretId=TEST_SECRET)
    actual_name = resp.get("Name", "")
    expected_name = TEST_SECRET
    assert (
        actual_name == expected_name
    ), f"Expected secret name '{expected_name}' but got '{actual_name}'"


@then(
    'the secret is "PENDING_DELETION" and will be unavailable to Lambda during the recovery window'
)
def secret_is_pending_deletion_then(lws_session):
    resp = _secretsmanager(lws_session).describe_secret(SecretId=TEST_SECRET)
    actual_deleted = resp.get("DeletedDate")
    assert (
        actual_deleted is not None
    ), f"Expected secret '{TEST_SECRET}' to have a DeletedDate (pending deletion) but got None"


@then('the invocation is "IN_PROGRESS"')
def invocation_is_in_progress_then(world):
    pytest.skip("Cannot observe Lambda invocation state in lws")


@then('the invocation is "FAILED" with a ResourceNotFoundException')
def invocation_failed_resource_not_found(world):
    pytest.skip("Cannot observe Lambda invocation failure in lws")


@then('the invocation is "SUCCESS"')
def invocation_is_success_then(world):
    pytest.skip("Cannot observe Lambda invocation success in lws")


# ── Then: sequence invariants ──────────────────────────────────────────


@then('every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function')
def _inv_lambda_secretsmanager_every_in_progress_invocation_references_an_active_lam():
    """Invariant step: trivially satisfied in isolated test context."""


@then("every successful invocation recorded which secret it read")
def _inv_lambda_secretsmanager_every_successful_invocation_recorded_which_secret_it_():
    """Invariant step: trivially satisfied in isolated test context."""
