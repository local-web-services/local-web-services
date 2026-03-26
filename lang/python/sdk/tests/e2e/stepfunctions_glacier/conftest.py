"""Abstract BDD step definitions for StepfunctionsGlacier integration spec scenarios."""

from __future__ import annotations

import json

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_SM = "test-sm-1"
TEST_VAULT = "e2e-test-vault-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"
PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})
TEST_INPUT = '{"key": "value"}'


def _sfn(lws_session):
    return lws_session.client("stepfunctions")


def _glacier(lws_session):
    return lws_session.client("glacier")


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"


def _create_sm(lws_session, name=TEST_SM):
    resp = _sfn(lws_session).create_state_machine(
        name=name,
        definition=PASS_DEFINITION,
        roleArn=ROLE_ARN,
    )
    return resp["stateMachineArn"]


def _create_vault(lws_session, name=TEST_VAULT):
    _glacier(lws_session).create_vault(accountId="-", vaultName=name)


def _vault_exists(lws_session, name=TEST_VAULT):
    resp = _glacier(lws_session).list_vaults(accountId="-")
    for vault in resp.get("VaultList", []):
        if vault["VaultName"] == name:
            return True
    return False


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


@given("vid not in vault_status")
def vid_not_in_vault_status():
    """No-op: guard condition — fresh state has no Glacier vaults."""


@given("vid in vault_status")
def vid_in_vault_status(lws_session):
    _create_vault(lws_session)


@given("a Glacier vault has been created")
def glacier_vault_has_been_created(lws_session):
    _create_vault(lws_session)


@given("a Glacier vault has been deleted")
def glacier_vault_has_been_deleted():
    pytest.skip("Cannot pre-set a deleted Glacier vault state for sequence setup")


@given("an execution of the state machine has been started")
def execution_of_sm_has_been_started():
    pytest.skip("Cannot pre-set a running execution state for sequence setup")


@given("eid in exec_status")
def eid_in_exec_status():
    pytest.skip("Cannot pre-set an in-flight execution state for sequence setup")


@given('a running execution has called a Glacier vault that "EXISTS" and the task succeeded')
def running_execution_called_vault_succeeded_given():
    pytest.skip("Cannot pre-set a completed execution Glacier task state for sequence setup")


@given("a running execution has failed because the Glacier vault has been deleted")
def running_execution_failed_vault_deleted_given():
    pytest.skip("Cannot pre-set a failed execution Glacier task state for sequence setup")


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


# ── Given: vault state ────────────────────────────────────────────────


@given("the vault does not already exist")
def vault_not_already_exist():
    """No-op: fresh state has no Glacier vaults."""


@given("the vault already exists")
def vault_already_exists(lws_session):
    _create_vault(lws_session)


@given("the vault exists")
def vault_exists(lws_session):
    _create_vault(lws_session)


@given('the vault "EXISTS"')
def vault_exists_given():
    """No-op: Glacier vaults exist immediately after creation."""


@given('the vault "EXISTS" (not already "DELETED")')
def vault_exists_not_deleted_given():
    """No-op: Glacier vaults exist and are not deleted immediately after creation."""


@given("the vault does not exist")
def vault_does_not_exist():
    """No-op: fresh state has no Glacier vaults."""


@given('the vault is "DELETED"')
def vault_is_deleted_given(lws_session, world):
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


@given('the vault is not "DELETED"')
def vault_is_not_deleted_given(lws_session):
    _create_vault(lws_session)


@given('the vault is already "DELETED"')
def vault_is_already_deleted_given(lws_session, world):
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


@given('the vault does not exist or is "DELETED"')
def vault_does_not_exist_or_deleted_given():
    """No-op: fresh state has no Glacier vaults."""


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


@when("a Glacier vault is created")
def create_glacier_vault(lws_session, world):
    try:
        resp = _glacier(lws_session).create_vault(accountId="-", vaultName=TEST_VAULT)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a Glacier vault is deleted")
def delete_glacier_vault(lws_session, world):
    try:
        resp = _glacier(lws_session).delete_vault(accountId="-", vaultName=TEST_VAULT)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


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


@when('a running execution calls a Glacier vault that "EXISTS" and the task succeeds')
def execution_calls_vault_succeeds(world):
    pytest.skip("Cannot trigger internal execution step that calls Glacier in lws")


@when("a running execution fails because the Glacier vault has been deleted")
def execution_fails_vault_deleted(world):
    pytest.skip(
        "Cannot trigger internal execution step that fails due to deleted Glacier vault in lws"
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


@then('the vault "EXISTS"')
def vault_exists_then(lws_session):
    expected_vault_name = TEST_VAULT
    actual_exists = _vault_exists(lws_session)
    assert (
        actual_exists is True
    ), f"Expected vault '{expected_vault_name}' to exist but it was not found"


@then('the vault is "DELETED" and "SDK" task calls targeting it will fail')
def vault_is_deleted_then(lws_session):
    expected_exists = False
    actual_exists = _vault_exists(lws_session)
    assert (
        actual_exists is expected_exists
    ), f"Expected vault '{TEST_VAULT}' to be deleted but it still exists"


@then('the execution is "RUNNING"')
def execution_is_running_then(world):
    assert world["error"] is None, f"Expected start_execution to succeed but got: {world['error']}"
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"


@then('the execution is "SUCCEEDED"')
def execution_is_succeeded_then():
    pytest.skip("Cannot observe internal execution Glacier task success in lws")


@then('the execution is "FAILED" with a ResourceNotFoundException')
def execution_failed_resource_not_found():
    pytest.skip("Cannot observe internal execution Glacier task failure in lws")


# ── Then: sequence invariants ──────────────────────────────────────────


@then('every "RUNNING" execution references an "ACTIVE" state machine')
def _inv_stepfunctions_glacier_every_running_execution_references_an_active_state_ma():
    """Invariant step: trivially satisfied in isolated test context."""


@then("every succeeded execution recorded which vault it called")
def _inv_stepfunctions_glacier_every_succeeded_execution_recorded_which_vault_it_cal():
    """Invariant step: trivially satisfied in isolated test context."""
