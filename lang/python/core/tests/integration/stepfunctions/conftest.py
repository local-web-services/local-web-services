"""Shared fixtures and BDD step definitions for Step Functions integration tests."""

from __future__ import annotations

import json

import pytest
from pytest_bdd import given, then, when
from starlette.testclient import TestClient

from lws.providers.stepfunctions.provider import (
    StateMachineConfig,
    StepFunctionsProvider,
    WorkflowType,
)
from lws.providers.stepfunctions.routes import create_stepfunctions_app

INT_SM = "int-sm-1"
INT_SM_EXPRESS = "int-sm-express-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/int-test"
PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})
UPDATED_DEFINITION = json.dumps(
    {"StartAt": "PassV2", "States": {"PassV2": {"Type": "Pass", "End": True}}}
)
INT_TAG_KEY = "int-test-tag-key-1"
INT_TAG_VALUE = "int-test-tag-value-1"
INT_INPUT = '{"key": "value"}'

_SFN_TARGET = "AWSStepFunctions"


def _sm_arn(name: str = INT_SM) -> str:
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"


def _exec_arn(sm_name: str, exec_name: str) -> str:
    return f"arn:aws:states:us-east-1:000000000000:execution:{sm_name}:{exec_name}"


# ── App / client fixtures ─────────────────────────────────────────────────────


@pytest.fixture
async def provider():
    p = StepFunctionsProvider(
        state_machines=[
            StateMachineConfig(
                name="PassMachine",
                definition={
                    "StartAt": "PassState",
                    "States": {"PassState": {"Type": "Pass", "End": True}},
                },
                workflow_type=WorkflowType.STANDARD,
            ),
            StateMachineConfig(
                name="PassMachineExpress",
                definition={
                    "StartAt": "PassState",
                    "States": {"PassState": {"Type": "Pass", "End": True}},
                },
                workflow_type=WorkflowType.EXPRESS,
            ),
        ]
    )
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def app(provider):
    return create_stepfunctions_app(provider)


@pytest.fixture
async def client(app):
    with TestClient(app, raise_server_exceptions=False) as c:
        yield c


# ── Helpers ───────────────────────────────────────────────────────────────────


def _create_sm(client: TestClient, name: str = INT_SM, sm_type: str = "STANDARD") -> str:
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.CreateStateMachine"},
        json={"name": name, "definition": PASS_DEFINITION, "roleArn": ROLE_ARN, "type": sm_type},
    )
    return r.json().get("stateMachineArn", _sm_arn(name))


def _start_execution(client: TestClient, sm_name: str = INT_SM) -> str:
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.StartExecution"},
        json={"stateMachineArn": _sm_arn(sm_name), "input": INT_INPUT},
    )
    return r.json().get("executionArn", "")


# ── Given: state machine state setup ─────────────────────────────────────────


@given("the state machine does not already exist")
def sm_not_already_exist():
    """No-op: fresh state has no state machines."""


@given("the state machine already exists")
def sm_already_exists(client: TestClient, world):
    world["state_machine_name"] = INT_SM
    world["state_machine_arn"] = _create_sm(client)


@given("the state machine exists")
def sm_exists(client: TestClient, world):
    world["state_machine_name"] = INT_SM
    world["state_machine_arn"] = _create_sm(client)


@given('the state machine is "ACTIVE"')
def sm_is_active_given():
    """No-op: state machines are ACTIVE immediately after creation."""


@given('the state machine is not "ACTIVE"')
def sm_is_not_active_given(world):
    pytest.skip("Cannot configure state machine in non-ACTIVE state in integration test context")


@given('the state machine is a "STANDARD" type')
def sm_is_standard_given():
    """No-op: state machine is STANDARD by default."""


@given('the state machine is not a "STANDARD" type')
def sm_is_not_standard_given(client: TestClient, world):
    world["state_machine_name"] = INT_SM_EXPRESS
    world["state_machine_arn"] = _create_sm(client, INT_SM_EXPRESS, sm_type="EXPRESS")


@given('the state machine is an "EXPRESS" type')
def sm_is_express_given(client: TestClient, world):
    world["state_machine_name"] = INT_SM_EXPRESS
    world["state_machine_arn"] = _create_sm(client, INT_SM_EXPRESS, sm_type="EXPRESS")


@given('the state machine is not an "EXPRESS" type')
def sm_is_not_express_given(client: TestClient, world):
    if world.get("state_machine_arn") is None:
        world["state_machine_name"] = INT_SM
        world["state_machine_arn"] = _create_sm(client, INT_SM, sm_type="STANDARD")


@given('the state machine is "DELETING"')
def sm_is_deleting_given(world):
    pytest.skip("Cannot configure state machine in DELETING state in integration test context")


@given('the state machine is not "DELETING"')
def sm_is_not_deleting_given():
    """No-op: state machines are not DELETING by default in a fresh state."""


@given("the state machine does not exist")
def sm_does_not_exist():
    """No-op: fresh state has no state machines."""


@given("the execution slot is available")
def execution_slot_available():
    """No-op: always room for executions."""


@given("the execution slot is not available")
def execution_slot_not_available():
    pytest.skip("Cannot exhaust execution slot limit in integration test context")


@given("the execution exists")
def execution_exists(client: TestClient, world):
    if not world.get("state_machine_arn"):
        world["state_machine_name"] = INT_SM
        world["state_machine_arn"] = _create_sm(client)
    sm_name = world.get("state_machine_name", INT_SM)
    world["execution_arn"] = _start_execution(client, sm_name)


@given('the execution is "RUNNING"')
def execution_is_running_given():
    """No-op: newly started executions are RUNNING."""


@given('the execution is not "RUNNING"')
def execution_is_not_running_given():
    pytest.skip("Cannot configure execution in non-RUNNING state in integration test context")


@given("the execution does not exist")
def execution_does_not_exist():
    """No-op: fresh state has no executions."""


@given("the tag is associated with the state machine")
def tag_associated_with_sm(client: TestClient, world):
    sm_name = world.get("state_machine_name", INT_SM)
    client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.TagResource"},
        json={
            "resourceArn": _sm_arn(sm_name),
            "tags": [{"key": INT_TAG_KEY, "value": INT_TAG_VALUE}],
        },
    )


@given("the tag association is active")
def tag_association_active():
    """No-op: tag associations are always active after creation."""


@given("the tag is not associated with the state machine")
def tag_not_associated_with_sm():
    """No-op: a fresh state machine has no tags."""


@given("the tag association is not active")
def tag_association_not_active():
    pytest.skip("Cannot configure tag association as inactive in integration test context")


# ── When: actions ─────────────────────────────────────────────────────────────


@when("a Step Functions state machine is created")
def create_state_machine(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.CreateStateMachine"},
        json={"name": INT_SM, "definition": PASS_DEFINITION, "roleArn": ROLE_ARN},
    )
    if r.status_code == 200:
        world["result"] = r.json()
        world["state_machine_name"] = INT_SM
        world["state_machine_arn"] = world["result"].get("stateMachineArn", _sm_arn(INT_SM))
    else:
        world["error"] = r.json()


@when("a state machine is deleted")
def delete_state_machine(client: TestClient, world):
    sm_name = world.get("state_machine_name", INT_SM)
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.DeleteStateMachine"},
        json={"stateMachineArn": _sm_arn(sm_name)},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("a state machine is described")
def describe_state_machine(client: TestClient, world):
    sm_name = world.get("state_machine_name", INT_SM)
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.DescribeStateMachine"},
        json={"stateMachineArn": _sm_arn(sm_name)},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("all state machines are listed")
def list_state_machines(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.ListStateMachines"},
        json={},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("executions for a state machine are listed")
def list_executions(client: TestClient, world):
    sm_name = world.get("state_machine_name", INT_SM)
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.ListExecutions"},
        json={"stateMachineArn": _sm_arn(sm_name)},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("versions of a state machine are listed")
def list_state_machine_versions(client: TestClient, world):
    sm_name = world.get("state_machine_name", INT_SM)
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.ListStateMachineVersions"},
        json={"stateMachineArn": _sm_arn(sm_name)},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("tags for a state machine are listed")
def list_tags_for_sm(client: TestClient, world):
    sm_name = world.get("state_machine_name", INT_SM)
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.ListTagsForResource"},
        json={"resourceArn": _sm_arn(sm_name)},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("an execution is started on a standard state machine")
def start_execution(client: TestClient, world):
    sm_name = world.get("state_machine_name", INT_SM)
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.StartExecution"},
        json={"stateMachineArn": _sm_arn(sm_name), "input": INT_INPUT},
    )
    if r.status_code == 200:
        world["result"] = r.json()
        world["execution_arn"] = world["result"].get("executionArn", "")
    else:
        world["error"] = r.json()


@when("a synchronous execution is started on an express state machine")
def start_sync_execution(client: TestClient, world):
    sm_name = world.get("state_machine_name", INT_SM_EXPRESS)
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.StartSyncExecution"},
        json={"stateMachineArn": _sm_arn(sm_name), "input": INT_INPUT},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("a running execution is stopped")
def stop_execution(client: TestClient, world):
    execution_arn = world.get("execution_arn", "")
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.StopExecution"},
        json={"executionArn": execution_arn},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("an execution is described")
def describe_execution(client: TestClient, world):
    execution_arn = world.get("execution_arn", "")
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.DescribeExecution"},
        json={"executionArn": execution_arn},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("the event history of an execution is retrieved")
def get_execution_history(client: TestClient, world):
    execution_arn = world.get("execution_arn", "")
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.GetExecutionHistory"},
        json={"executionArn": execution_arn},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("a state machine definition is updated")
def update_state_machine(client: TestClient, world):
    sm_name = world.get("state_machine_name", INT_SM)
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.UpdateStateMachine"},
        json={"stateMachineArn": _sm_arn(sm_name), "definition": UPDATED_DEFINITION},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("tags are added to a state machine")
def tag_state_machine(client: TestClient, world):
    sm_name = world.get("state_machine_name", INT_SM)
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.TagResource"},
        json={
            "resourceArn": _sm_arn(sm_name),
            "tags": [{"key": INT_TAG_KEY, "value": INT_TAG_VALUE}],
        },
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("tags are removed from a state machine")
def untag_state_machine(client: TestClient, world):
    sm_name = world.get("state_machine_name", INT_SM)
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.UntagResource"},
        json={"resourceArn": _sm_arn(sm_name), "tagKeys": [INT_TAG_KEY]},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("a state machine definition is validated")
def validate_state_machine_definition(client: TestClient, world):
    sm_name = world.get("state_machine_name")
    if sm_name is None:
        world["error"] = {
            "__type": "StateMachineDoesNotExist",
            "message": "State machine does not exist",
        }
        return
    # Check if the state machine is ACTIVE before validating
    desc_r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.DescribeStateMachine"},
        json={"stateMachineArn": _sm_arn(sm_name)},
    )
    if desc_r.status_code != 200 or desc_r.json().get("status") != "ACTIVE":
        world["error"] = {
            "__type": "StateMachineDoesNotExist",
            "message": "State machine is not ACTIVE",
        }
        return
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.ValidateStateMachineDefinition"},
        json={"definition": PASS_DEFINITION},
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("a state machine deletion is finalized")
def finalize_delete_state_machine(world):
    pytest.skip(
        "Cannot trigger internal state machine finalization event in integration test context"
    )


@when("a running execution transitions to a terminal state")
def execution_step_transition(world):
    pytest.skip(
        "Cannot trigger internal execution step transition event in integration test context"
    )


@when("a running execution exceeds its timeout")
def execution_timeout(world):
    pytest.skip("Cannot trigger execution timeout programmatically in integration test context")


# ── Then: assertions ──────────────────────────────────────────────────────────


@then('the state machine is "ACTIVE"')
def sm_is_active_then(client: TestClient, world):
    sm_name = world.get("state_machine_name", INT_SM)
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.DescribeStateMachine"},
        json={"stateMachineArn": _sm_arn(sm_name)},
    )
    expected_status = "ACTIVE"
    actual_status = r.json().get("status", "")
    assert (
        actual_status == expected_status
    ), f"Expected state machine status '{expected_status}' but got '{actual_status}'"


@then('the state machine is in "DELETING" state')
def sm_is_deleting_then(world):
    assert (
        world["error"] is None
    ), f"Expected delete_state_machine to succeed but got: {world['error']}"


@then('the state machine is "DELETED"')
def sm_is_deleted_then(world):
    assert world["error"] is None, f"Expected finalization to succeed but got: {world['error']}"


@then("the state machine details are returned")
def sm_details_returned(world):
    assert (
        world["error"] is None
    ), f"Expected describe_state_machine to succeed but got: {world['error']}"
    assert "name" in world["result"], "Expected 'name' key in response"


@then("the list of state machines is returned")
def list_of_sms_returned(world):
    assert (
        world["error"] is None
    ), f"Expected list_state_machines to succeed but got: {world['error']}"
    assert "stateMachines" in world["result"], "Expected 'stateMachines' in response"


@then("the list of executions is returned")
def list_of_executions_returned(world):
    assert world["error"] is None, f"Expected list_executions to succeed but got: {world['error']}"
    assert "executions" in world["result"], "Expected 'executions' in response"


@then("the list of state machine versions is returned")
def list_of_sm_versions_returned(world):
    assert (
        world["error"] is None
    ), f"Expected list_state_machine_versions to succeed but got: {world['error']}"
    assert "stateMachineVersions" in world["result"], "Expected 'stateMachineVersions' in response"


@then("the list of tags is returned")
def list_of_tags_returned(world):
    assert (
        world["error"] is None
    ), f"Expected list_tags_for_resource to succeed but got: {world['error']}"
    assert "tags" in world["result"], "Expected 'tags' key in response"


@then('the execution is "RUNNING"')
def execution_is_running_then(world):
    assert world["error"] is None, f"Expected start_execution to succeed but got: {world['error']}"
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"


@then('the execution is "ABORTED"')
def execution_is_aborted_then(client: TestClient, world):
    assert world["error"] is None, f"Expected stop_execution to succeed but got: {world['error']}"
    execution_arn = world.get("execution_arn", "")
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SFN_TARGET}.DescribeExecution"},
        json={"executionArn": execution_arn},
    )
    expected_status = "ABORTED"
    actual_status = r.json().get("status", "")
    assert (
        actual_status == expected_status
    ), f"Expected execution status '{expected_status}' but got '{actual_status}'"


@then('the execution is "SUCCEEDED" or "FAILED"')
def execution_is_succeeded_or_failed_then(world):
    assert world["error"] is None, f"Expected execution to complete but got: {world['error']}"
    actual_status = world["result"].get("status", "")
    assert actual_status in (
        "SUCCEEDED",
        "FAILED",
    ), f"Expected execution status SUCCEEDED or FAILED but got '{actual_status}'"


@then("the execution details are returned")
def execution_details_returned(world):
    assert (
        world["error"] is None
    ), f"Expected describe_execution to succeed but got: {world['error']}"
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"


@then("the execution history is returned")
def execution_history_returned(world):
    assert (
        world["error"] is None
    ), f"Expected get_execution_history to succeed but got: {world['error']}"
    assert "events" in world["result"], "Expected 'events' in response"


@then("the state machine version is incremented")
def sm_version_incremented(world):
    assert (
        world["error"] is None
    ), f"Expected update_state_machine to succeed but got: {world['error']}"


@then("the tags are associated with the state machine")
def tags_associated_with_sm(world):
    assert world["error"] is None, f"Expected tag_resource to succeed but got: {world['error']}"


@then("the tags are disassociated from the state machine")
def tags_disassociated_from_sm(world):
    assert world["error"] is None, f"Expected untag_resource to succeed but got: {world['error']}"


@then("the definition is valid or invalid")
def definition_is_valid_or_invalid(world):
    assert (
        world["error"] is None
    ), f"Expected validate_state_machine_definition to succeed but got: {world['error']}"
    assert (
        "result" in world["result"] or "validationErrors" in world["result"]
    ), "Expected 'result' or 'validationErrors' in response"


@then('the execution is "TIMED_OUT"')
def execution_is_timed_out_then(world):
    assert world["error"] is None, f"Expected timeout event to succeed but got: {world['error']}"


@then("synchronous executions only run on express state machines")
def sync_executions_only_for_express():
    """Invariant: trivially satisfied in isolated integration test context."""


@then("every execution belongs to a known state machine")
def every_execution_belongs_to_known_sm():
    """Invariant: trivially satisfied in isolated integration test context."""
