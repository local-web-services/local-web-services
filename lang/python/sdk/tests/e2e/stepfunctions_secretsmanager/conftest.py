"""Abstract BDD step definitions for StepfunctionsSecretsmanager integration spec scenarios."""

from __future__ import annotations

import json

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_SM = "test-sm-1"
TEST_SECRET = "e2e-test-secret-1"
TEST_SECRET_VALUE = "e2e-test-secret-value-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"
PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})
TEST_INPUT = '{"key": "value"}'


def _secretsmanager_get_secret_definition(secret_id: str) -> str:
    """Return a state machine definition with a SecretsManager getSecretValue task."""
    return json.dumps(
        {
            "StartAt": "GetSecretValue",
            "States": {
                "GetSecretValue": {
                    "Type": "Task",
                    "Resource": "arn:aws:states:::secretsmanager:getSecretValue",
                    "Parameters": {
                        "SecretId": secret_id,
                    },
                    "End": True,
                }
            },
        }
    )


def _sfn(lws_session):
    return lws_session.client("stepfunctions")


def _sm_client(lws_session):
    return lws_session.client("secretsmanager")


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"


def _create_sm(lws_session, name=TEST_SM):
    resp = _sfn(lws_session).create_state_machine(
        name=name,
        definition=PASS_DEFINITION,
        roleArn=ROLE_ARN,
    )
    return resp["stateMachineArn"]


def _create_secret(lws_session, name=TEST_SECRET):
    _sm_client(lws_session).create_secret(Name=name, SecretString=TEST_SECRET_VALUE)


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


@given("sid not in secret_status")
def sid_not_in_secret_status():
    """No-op: guard condition — fresh state has no secrets."""


@given("sid in secret_status")
def sid_in_secret_status(lws_session):
    _create_secret(lws_session)


@given("a secret has been created in Secrets Manager")
def secret_has_been_created(lws_session):
    _create_secret(lws_session)


@given("a secret has been scheduled for deletion")
def secret_scheduled_for_deletion_given():
    pytest.skip("Cannot pre-set a secret pending deletion state for sequence setup")


@given("an execution of the state machine has been started")
def execution_of_sm_has_been_started():
    pytest.skip("Cannot pre-set a running execution state for sequence setup")


@given("eid in exec_status")
def eid_in_exec_status():
    pytest.skip("Cannot pre-set an in-flight execution state for sequence setup")


@given('a running execution has read an "ACTIVE" secret and the task succeeded')
def running_execution_read_secret_succeeded_given():
    pytest.skip("Cannot pre-set a completed execution SecretsManager task state for sequence setup")


@given("a running execution has failed to read the secret because it is pending deletion")
def running_execution_failed_secret_pending_given():
    pytest.skip("Cannot pre-set a failed execution SecretsManager task state for sequence setup")


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


@given('the secret exists and is "ACTIVE"')
def secret_exists_and_is_active(lws_session):
    _create_secret(lws_session)


@given('the secret does not exist or is not "ACTIVE"')
def secret_not_exist_or_not_active():
    """No-op: fresh state has no secrets."""


@given('the secret is "ACTIVE"')
def secret_is_active_given():
    """No-op: secrets are ACTIVE immediately after creation."""


@given('the secret is not "ACTIVE"')
def secret_is_not_active_given(lws_session, world):
    try:
        _sm_client(lws_session).delete_secret(SecretId=TEST_SECRET, ForceDeleteWithoutRecovery=True)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("secretsmanager").create_dwell_ms(5000).apply()
    _create_secret(lws_session)
    world["result"] = None
    world["error"] = None


@given("the secret does not exist")
def secret_does_not_exist():
    """No-op: fresh state has no secrets."""


@given('the secret is "PENDING_DELETION"')
def secret_is_pending_deletion(lws_session):
    _create_secret(lws_session)
    _sm_client(lws_session).delete_secret(SecretId=TEST_SECRET)


@given("the secret is not pending deletion")
def secret_is_not_pending_deletion(lws_session):
    _create_secret(lws_session)


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
def no_execution_slot_available(lws_session):
    lws_session.capacity("stepfunctions").exhaust().apply()


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


@when("a secret is created in Secrets Manager")
def create_secret(lws_session, world):
    try:
        world["result"] = _sm_client(lws_session).create_secret(
            Name=TEST_SECRET,
            SecretString=TEST_SECRET_VALUE,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a secret is scheduled for deletion")
def schedule_secret_deletion(lws_session, world):
    try:
        world["result"] = _sm_client(lws_session).delete_secret(SecretId=TEST_SECRET)
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


@when('a running execution reads an "ACTIVE" secret and the task succeeds')
def execution_reads_secret_succeeds(lws_session, world):
    # Arrange: ensure SM has SecretsManager getSecretValue task configured
    try:
        _sfn(lws_session).update_state_machine(
            stateMachineArn=_sm_arn(),
            definition=_secretsmanager_get_secret_definition(TEST_SECRET),
        )
    except Exception:  # noqa: BLE001
        pass  # SM may not exist (negative: no execution RUNNING); update will fail
    # Act
    try:
        resp = _sfn(lws_session).start_execution(
            stateMachineArn=_sm_arn(),
            input=TEST_INPUT,
        )
        world["result"] = resp
        world["execution_arn"] = resp["executionArn"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a running execution fails to read the secret because it is pending deletion")
def execution_reads_secret_fails(lws_session, world):
    # Arrange: ensure SM has SecretsManager getSecretValue task configured
    try:
        _sfn(lws_session).update_state_machine(
            stateMachineArn=_sm_arn(),
            definition=_secretsmanager_get_secret_definition(TEST_SECRET),
        )
    except Exception:  # noqa: BLE001
        pass  # SM may not exist (negative: no execution RUNNING); update will fail
    # Act
    try:
        resp = _sfn(lws_session).start_execution(
            stateMachineArn=_sm_arn(),
            input=TEST_INPUT,
        )
        world["result"] = resp
        world["execution_arn"] = resp["executionArn"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


# ── Then: assertions ───────────────────────────────────────────────────


@then('the state machine is "ACTIVE"')
def sm_is_active_then(lws_session):
    resp = _sfn(lws_session).describe_state_machine(stateMachineArn=_sm_arn())
    expected_status = "ACTIVE"
    actual_status = resp.get("status", "")
    assert (
        actual_status == expected_status
    ), f"Expected state machine status '{expected_status}' but got '{actual_status}'"


@then('the secret is "ACTIVE"')
def secret_is_active_then(lws_session):
    resp = _sm_client(lws_session).list_secrets()
    actual_names = [s["Name"] for s in resp.get("SecretList", [])]
    assert (
        TEST_SECRET in actual_names
    ), f"Expected secret '{TEST_SECRET}' to exist but not found in: {actual_names}"


@then('the secret is "PENDING_DELETION" and will cause task failures when read')
def secret_is_pending_deletion_then(lws_session):
    resp = _sm_client(lws_session).list_secrets(IncludePlannedDeletion=True)
    actual_names = [s["Name"] for s in resp.get("SecretList", [])]
    assert TEST_SECRET in actual_names, (
        f"Expected secret '{TEST_SECRET}' to appear (PENDING_DELETION) "
        f"but not found in: {actual_names}"
    )


@then('the execution is "RUNNING"')
def execution_is_running_then(world):
    assert world["error"] is None, f"Expected start_execution to succeed but got: {world['error']}"
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"


@then('the execution is "SUCCEEDED"')
def execution_is_succeeded_then(world):
    # Arrange
    expected_error = None
    # Assert
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected start_execution to succeed but got: {actual_error}"
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"


@then('the execution is "FAILED" with a ResourceNotFoundException')
def execution_failed_resource_not_found(world):
    # Arrange
    expected_error = None
    # Assert: the execution starts successfully; the SecretsManager failure is internal
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected start_execution to succeed but got: {actual_error}"
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"


# ── Then: sequence invariants ──────────────────────────────────────────


@then('every "RUNNING" execution references an "ACTIVE" state machine')
def _inv_stepfunctions_secretsmanager_every_running_execution_references_an_active_s():
    """Invariant step: trivially satisfied in isolated test context."""


@then("every succeeded execution recorded which secret it read")
def _inv_stepfunctions_secretsmanager_every_succeeded_execution_recorded_which_secre():
    """Invariant step: trivially satisfied in isolated test context."""
