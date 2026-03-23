"""Abstract BDD step definitions for SecretsmanagerLambda integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_SECRET = "e2e-test-secret-1"
TEST_FUNC = "e2e-test-func-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"
TEST_SECRET_VALUE = "e2e-test-secret-value-1"


def _secretsmanager(lws_session):
    return lws_session.client("secretsmanager")


def _lambda(lws_session):
    return lws_session.client("lambda")


def _create_secret(lws_session, name=TEST_SECRET):
    _secretsmanager(lws_session).create_secret(Name=name, SecretString=TEST_SECRET_VALUE)


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


# ── Given: secret state ───────────────────────────────────────────────


@given("the secret does not already exist")
def sm_lambda_secret_not_already_exist():
    """No-op: fresh state has no secrets."""


@given("the secret already exists")
def sm_lambda_secret_already_exists(lws_session):
    _create_secret(lws_session)


@given('the secret exists and is "ACTIVE"')
def sm_lambda_secret_exists_and_active(lws_session):
    _create_secret(lws_session)


@given('the secret does not exist or is not "ACTIVE"')
def sm_lambda_secret_not_exist_or_not_active():
    """No-op: fresh state has no secrets."""


@given("the secret has no rotation function configured")
def sm_lambda_secret_has_no_rotation():
    """No-op: secrets have no rotation function configured by default."""


@given("the secret already has a rotation function configured")
def sm_lambda_secret_already_has_rotation():
    pytest.skip("Cannot configure secret rotation Lambda trigger in lws")


@given("the secret has a rotation function configured")
def sm_lambda_secret_has_rotation():
    pytest.skip("Cannot configure secret rotation Lambda trigger in lws")


# ── Given: function state ─────────────────────────────────────────────


@given("the function does not already exist")
def sm_lambda_function_not_already_exist():
    """No-op: fresh state has no Lambda functions."""


@given("the function already exists")
def sm_lambda_function_already_exists(lws_session):
    _create_function(lws_session)


@given("the function exists")
def sm_lambda_function_exists(lws_session):
    _create_function(lws_session)


@given('the function exists and is "ACTIVE"')
def sm_lambda_function_exists_and_active(lws_session):
    _create_function(lws_session)


@given('the function does not exist or is not "ACTIVE"')
def sm_lambda_function_not_exist_or_not_active():
    """No-op: fresh state has no functions."""


@given('the function is "ACTIVE"')
def sm_lambda_function_is_active_given():
    """No-op: Lambda functions are ACTIVE immediately after creation."""


@given('the function is not "ACTIVE"')
def sm_lambda_function_is_not_active_given(lws_session, world):
    try:
        _lambda(lws_session).delete_function(FunctionName=TEST_FUNC)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("lambda").create_dwell_ms(5000).apply()
    _create_function(lws_session)
    world["result"] = None
    world["error"] = None


@given("the function does not exist")
def sm_lambda_function_does_not_exist():
    """No-op: fresh state has no Lambda functions."""


@given('the function is already "DELETED"')
def sm_lambda_function_is_already_deleted(lws_session, world):
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


@given('the rotation function is "ACTIVE"')
def sm_lambda_rotation_function_active():
    pytest.skip("Cannot configure secret rotation Lambda trigger in lws")


@given('the rotation function is not "ACTIVE"')
def sm_lambda_rotation_function_not_active():
    pytest.skip("Cannot configure secret rotation Lambda trigger in lws")


@given('the rotation function is "DELETED"')
def sm_lambda_rotation_function_deleted():
    pytest.skip("Cannot configure secret rotation Lambda trigger in lws")


@given('the rotation function is not "DELETED"')
def sm_lambda_rotation_function_not_deleted():
    pytest.skip("Cannot configure secret rotation Lambda trigger in lws")


# ── Given: slots ───────────────────────────────────────────────────────


@given("an invocation slot is available")
def sm_lambda_invocation_slot_available(lws_session):
    lws_session.capacity("lambda").unlimited().apply()


@given("no invocation slot is available")
def sm_lambda_no_invocation_slot_available(lws_session):
    lws_session.capacity("lambda").exhaust().apply()


# ── Given: invocation state ───────────────────────────────────────────


@given('an invocation is "IN_PROGRESS"')
def sm_lambda_invocation_is_in_progress():
    pytest.skip("Cannot trigger SecretsManager->Lambda invocation in lws")


@given('no invocation is "IN_PROGRESS"')
def sm_lambda_no_invocation_is_in_progress():
    """No-op: fresh state has no in-progress invocations."""


# ── When: actions ──────────────────────────────────────────────────────


@when("a secret is created in Secrets Manager")
def create_secret_sm(lws_session, world):
    try:
        resp = _secretsmanager(lws_session).create_secret(
            Name=TEST_SECRET, SecretString=TEST_SECRET_VALUE
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("a Lambda rotation function is deployed")
def deploy_lambda_rotation_function(lws_session, world):
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


@when("rotation is configured on the secret linking it to the Lambda rotation function")
def configure_rotation(world):
    pytest.skip("Cannot configure secret rotation Lambda trigger in lws")


@when("a rotation is triggered for the secret")
def trigger_rotation(world):
    pytest.skip("Cannot trigger SecretsManager->Lambda invocation in lws")


@when("the rotation function is deleted")
def delete_rotation_function(lws_session, world):
    try:
        resp = _lambda(lws_session).delete_function(FunctionName=TEST_FUNC)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("the Lambda rotation function succeeds and the secret is rotated to a new version")
def rotation_function_succeeds(world):
    pytest.skip("Cannot trigger SecretsManager->Lambda invocation in lws")


@when("the Lambda rotation function fails and the rotation is aborted")
def rotation_function_fails(world):
    pytest.skip("Cannot trigger SecretsManager->Lambda invocation in lws")


# ── Then: assertions ───────────────────────────────────────────────────


@then('the secret is "ACTIVE"')
def sm_lambda_secret_is_active_then(lws_session):
    resp = _secretsmanager(lws_session).describe_secret(SecretId=TEST_SECRET)
    actual_name = resp.get("Name", "")
    expected_name = TEST_SECRET
    assert (
        actual_name == expected_name
    ), f"Expected secret '{expected_name}' to be ACTIVE but got '{actual_name}'"


@then('the function is "ACTIVE"')
def sm_lambda_function_is_active_then(lws_session):
    resp = _lambda(lws_session).get_function(FunctionName=TEST_FUNC)
    expected_state = "Active"
    actual_state = resp["Configuration"].get("State", "")
    assert (
        actual_state == expected_state
    ), f"Expected function state '{expected_state}' but got '{actual_state}'"


@then("the secret has a rotation function configured")
def secret_has_rotation_configured():
    pytest.skip("Cannot configure secret rotation Lambda trigger in lws")


@then('the secret is "ROTATING" and Secrets Manager invokes the Lambda rotation function')
def secret_is_rotating():
    pytest.skip("Cannot trigger SecretsManager->Lambda invocation in lws")


@then('the function is "DELETED" and rotation will fail')
def rotation_function_is_deleted(lws_session):
    expected_exists = False
    actual_exists = _get_function_exists(lws_session)
    assert (
        actual_exists == expected_exists
    ), "Expected rotation function to be deleted but it still exists"


@then('the invocation is "SUCCESS" and the secret is "ACTIVE" with a new version')
def invocation_success_secret_rotated():
    pytest.skip("Cannot trigger SecretsManager->Lambda invocation in lws")


@then('the invocation is "FAILED" and the secret remains "ACTIVE" with the old version')
def invocation_failed_secret_unchanged():
    pytest.skip("Cannot trigger SecretsManager->Lambda invocation in lws")
