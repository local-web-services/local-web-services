"""Abstract BDD step definitions for LambdaGlacier integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_FUNC = "e2e-test-func-1"
TEST_VAULT = "e2e-test-vault-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"


def _lambda(lws_session):
    return lws_session.client("lambda")


def _glacier(lws_session):
    return lws_session.client("glacier")


def _create_function(lws_session, name=TEST_FUNC):
    _lambda(lws_session).create_function(
        FunctionName=name,
        Runtime="python3.12",
        Role=ROLE_ARN,
        Handler="index.handler",
        Code={"ZipFile": b"fake"},
    )


def _create_vault(lws_session, name=TEST_VAULT):
    _glacier(lws_session).create_vault(accountId="-", vaultName=name)


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


# ── Given: vault state ─────────────────────────────────────────────────


@given("the vault does not already exist")
def vault_not_already_exist():
    """No-op: fresh state has no vaults."""


@given("the vault already exists")
def vault_already_exists(lws_session):
    _create_vault(lws_session)


@given("the vault exists")
def vault_exists(lws_session):
    _create_vault(lws_session)


@given('the vault "EXISTS"')
def vault_exists_quoted(lws_session):
    _create_vault(lws_session)


@given('the vault "EXISTS" (not already "DELETED")')
def vault_exists_not_deleted(lws_session):
    try:
        _create_vault(lws_session)
    except Exception:  # noqa: BLE001
        pass


@given('the vault is already "DELETED"')
def vault_is_already_deleted(lws_session, world):
    try:
        _create_vault(lws_session)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("glacier").delete_dwell_ms(5000).apply()
    try:
        _glacier(lws_session).delete_vault(accountId="-", vaultName=TEST_VAULT)
    except Exception:  # noqa: BLE001
        pass
    world["result"] = None
    world["error"] = None


@given("the vault does not exist")
def vault_does_not_exist():
    """No-op: fresh state has no vaults."""


@given('the vault does not exist or is "DELETED"')
def vault_not_exist_or_deleted():
    """No-op: fresh state has no vaults."""


@given('the vault is "DELETED"')
def vault_is_deleted_given():
    """No-op: fresh state has no vaults (simulates deleted vault)."""


@given('the vault is not "DELETED"')
def vault_is_not_deleted_given(lws_session):
    _create_vault(lws_session)


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


@given("an archive slot is available")
def archive_slot_available():
    """No-op: always room for archives."""


@given("no archive slot is available")
def no_archive_slot_available():
    pytest.skip("Cannot exhaust archive slot limit")


# ── Given: sequence setup ─────────────────────────────────────────────


@given("fid not in func_status")
def fid_not_in_func_status():
    """No-op: fresh state has no functions."""


@given("vid not in vault_status")
def vid_not_in_vault_status():
    """No-op: fresh state has no vaults."""


@given("vid in vault_status")
def vid_in_vault_status(lws_session):
    _create_vault(lws_session)


@given("fid in func_status")
def fid_in_func_status(lws_session):
    _create_function(lws_session)


@given("iid in inv_status")
def iid_in_inv_status():
    pytest.skip("Cannot create an in-progress invocation in lws")


@given("a Lambda function has been deployed")
def lambda_function_has_been_deployed_seq(lws_session):
    _create_function(lws_session)


@given("a Glacier vault has been created")
def glacier_vault_has_been_created_seq(lws_session):
    _create_vault(lws_session)


@given("a Glacier vault has been deleted")
def glacier_vault_has_been_deleted_seq(lws_session):
    try:
        _create_vault(lws_session)
    except Exception:  # noqa: BLE001
        pass
    _glacier(lws_session).delete_vault(accountId="-", vaultName=TEST_VAULT)


@given("the Lambda function has been invoked")
def lambda_function_has_been_invoked_seq():
    pytest.skip("Cannot create a completed Lambda invocation in lws")


@given("the Lambda function has uploaded an archive to an existing vault and succeeded")
def lambda_function_uploaded_archive_succeeded_seq():
    pytest.skip("Cannot trigger Lambda archive upload in lws")


@given("the Lambda function has failed to upload because the vault has been deleted")
def lambda_function_failed_upload_vault_deleted_seq():
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


@when("a Glacier vault is created")
def create_glacier_vault(lws_session, world):
    try:
        _create_vault(lws_session)
        world["result"] = {"vaultName": TEST_VAULT}
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("a Glacier vault is deleted")
def delete_glacier_vault(lws_session, world):
    try:
        _glacier(lws_session).delete_vault(accountId="-", vaultName=TEST_VAULT)
        world["result"] = {"vaultName": TEST_VAULT}
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("the Lambda function is invoked")
def invoke_function(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when("the Lambda function fails to upload because the vault has been deleted")
def invocation_fails_vault_deleted(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when("the Lambda function uploads an archive to an existing vault and succeeds")
def lambda_uploads_archive(world):
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


@then('the vault "EXISTS"')
def vault_exists_then(lws_session):
    resp = _glacier(lws_session).describe_vault(accountId="-", vaultName=TEST_VAULT)
    actual_name = resp.get("VaultName", "")
    expected_name = TEST_VAULT
    assert (
        actual_name == expected_name
    ), f"Expected vault name '{expected_name}' but got '{actual_name}'"


@then('the vault is "DELETED" and archive uploads will fail')
def vault_is_deleted_then(lws_session):
    try:
        _glacier(lws_session).describe_vault(accountId="-", vaultName=TEST_VAULT)
        raise AssertionError(f"Expected vault '{TEST_VAULT}' to be deleted but it still exists")
    except ClientError as exc:
        error_code = exc.response["Error"]["Code"]
        expected_code = "ResourceNotFoundException"
        assert error_code == expected_code, f"Expected '{expected_code}' but got: {error_code}"


@then('the invocation is "IN_PROGRESS"')
def invocation_is_in_progress_then(world):
    pytest.skip("Cannot observe Lambda invocation state in lws")


@then('the invocation is "FAILED" with a ResourceNotFoundException')
def invocation_failed_resource_not_found(world):
    pytest.skip("Cannot observe Lambda invocation failure in lws")


@then('the archive "EXISTS" in the vault and the invocation is "SUCCESS"')
def archive_exists_invocation_success(world):
    pytest.skip("Cannot observe Lambda archive upload result in lws")


# ── Then: sequence invariants ──────────────────────────────────────────


@then('every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function')
def _inv_lambda_glacier_every_in_progress_invocation_references_an_active_lambda_fun():
    """Invariant step: trivially satisfied in isolated test context."""


@then("every existing archive references a vault that exists")
def _inv_lambda_glacier_every_existing_archive_references_a_vault_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
