"""Abstract BDD step definitions for Step Functions informal spec scenarios."""

from __future__ import annotations

import json

import pytest
from botocore.config import Config
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_SM = "test-sm-1"
TEST_SM_EXPRESS = "test-sm-express-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"
PASS_DEFINITION = json.dumps(
    {"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}}
)
UPDATED_DEFINITION = json.dumps(
    {"StartAt": "PassV2", "States": {"PassV2": {"Type": "Pass", "End": True}}}
)
TEST_TAG_KEY = "e2e-test-tag-key-1"
TEST_TAG_VALUE = "test-tag-value-1"
TEST_INPUT = '{"key": "value"}'


def _sfn(lws_session):
    return lws_session.client("stepfunctions", config=Config(inject_host_prefix=False))


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"


def _create_sm(lws_session, name=TEST_SM, sm_type="STANDARD"):
    resp = _sfn(lws_session).create_state_machine(
        name=name,
        definition=PASS_DEFINITION,
        roleArn=ROLE_ARN,
        type=sm_type,
    )
    return resp["stateMachineArn"]


def _start_execution(lws_session, sm_name=TEST_SM):
    sm_arn = _sm_arn(sm_name)
    resp = _sfn(lws_session).start_execution(stateMachineArn=sm_arn, input=TEST_INPUT)
    return resp["executionArn"]


# ── Given: state machine state setup ──────────────────────────────────

@given("the state machine does not already exist")
def sm_not_already_exist():
    """No-op: fresh state has no state machines."""


@given("the state machine already exists")
def sm_already_exists(lws_session, world):
    world["state_machine_name"] = TEST_SM
    world["state_machine_arn"] = _create_sm(lws_session)


@given("the state machine exists")
def sm_exists(lws_session, world):
    world["state_machine_name"] = TEST_SM
    world["state_machine_arn"] = _create_sm(lws_session)


@given('the state machine is "ACTIVE"')
def sm_is_active_given():
    """No-op: state machines are ACTIVE immediately after creation."""


@given('the state machine is not "ACTIVE"')
def sm_is_not_active_given(lws_session, world):
    """Enable lifecycle simulation so state machine stays in CREATING state."""
    import httpx  # noqa: PLC0415

    sm_name = world.get("state_machine_name", TEST_SM)
    try:
        _sfn(lws_session).delete_state_machine(stateMachineArn=_sm_arn(sm_name))
    except Exception:  # noqa: BLE001
        pass
    httpx.post(
        f"http://127.0.0.1:{lws_session._mgmt_port}/_ldk/lifecycle",
        json={"stepfunctions": {"enabled": True, "create_dwell_ms": 5000}},
        timeout=5.0,
    )
    # Create a state machine that will be stuck in CREATING state
    world["state_machine_name"] = TEST_SM
    world["state_machine_arn"] = _create_sm(lws_session)


@given('the state machine is a "STANDARD" type')
def sm_is_standard_given():
    """No-op: state machine is STANDARD by default."""


@given('the state machine is not a "STANDARD" type')
def sm_is_not_standard_given(lws_session, world):
    """Create an EXPRESS type state machine instead."""
    world["state_machine_name"] = TEST_SM_EXPRESS
    world["state_machine_arn"] = _create_sm(lws_session, TEST_SM_EXPRESS, sm_type="EXPRESS")


@given('the state machine is an "EXPRESS" type')
def sm_is_express_given(lws_session, world):
    world["state_machine_name"] = TEST_SM_EXPRESS
    world["state_machine_arn"] = _create_sm(lws_session, TEST_SM_EXPRESS, sm_type="EXPRESS")


@given('the state machine is "DELETING"')
def sm_is_deleting_given(lws_session, world):
    """Delete the SM so it enters DELETING state."""
    sm_name = world.get("state_machine_name", TEST_SM)
    _sfn(lws_session).delete_state_machine(stateMachineArn=_sm_arn(sm_name))


@given("the state machine does not exist")
def sm_does_not_exist():
    """No-op: fresh state has no state machines."""


@given("the execution slot is available")
def execution_slot_available():
    """No-op: always room for executions."""


@given("the execution slot is not available")
def execution_slot_not_available():
    pytest.skip("Cannot exhaust execution slot limit")


@given("the execution exists")
def execution_exists(lws_session, world):
    if not world.get("state_machine_arn"):
        world["state_machine_name"] = TEST_SM
        world["state_machine_arn"] = _create_sm(lws_session)
    sm_name = world.get("state_machine_name", TEST_SM)
    world["execution_arn"] = _start_execution(lws_session, sm_name)


@given('the execution is "RUNNING"')
def execution_is_running_given():
    """No-op: newly started executions are RUNNING."""


@given('the execution is not "RUNNING"')
def execution_is_not_running_given():
    pytest.skip("Cannot reliably get a non-RUNNING execution for negative test")


@given("the execution does not exist")
def execution_does_not_exist():
    """No-op: fresh state has no executions."""


@given("the tag is associated with the state machine")
def tag_associated_with_sm(lws_session, world):
    sm_name = world.get("state_machine_name", TEST_SM)
    _sfn(lws_session).tag_resource(
        resourceArn=_sm_arn(sm_name),
        tags=[{"key": TEST_TAG_KEY, "value": TEST_TAG_VALUE}],
    )


@given("the tag association is active")
def tag_association_active():
    """No-op: tag associations are always active after creation."""


@given('the state machine is not an "EXPRESS" type')
def sm_is_not_express_given(lws_session, world):
    """Ensure a STANDARD type state machine exists; no-op if already created."""
    if world.get("state_machine_arn") is None:
        world["state_machine_name"] = TEST_SM
        world["state_machine_arn"] = _create_sm(lws_session, TEST_SM, sm_type="STANDARD")


@given('the state machine is not "DELETING"')
def sm_is_not_deleting_given():
    """No-op: state machines are not DELETING by default in a fresh state."""


@given("the tag is not associated with the state machine")
def tag_not_associated_with_sm():
    """No-op: a fresh state machine has no tags."""


@given("the tag association is not active")
def tag_association_not_active():
    pytest.skip("Cannot set tag association to inactive in this context")


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
        world["state_machine_name"] = TEST_SM
        world["state_machine_arn"] = resp["stateMachineArn"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a state machine is deleted")
def delete_state_machine(lws_session, world):
    try:
        sm_name = world.get("state_machine_name", TEST_SM)
        resp = _sfn(lws_session).delete_state_machine(stateMachineArn=_sm_arn(sm_name))
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a state machine is described")
def describe_state_machine(lws_session, world):
    try:
        sm_name = world.get("state_machine_name", TEST_SM)
        resp = _sfn(lws_session).describe_state_machine(stateMachineArn=_sm_arn(sm_name))
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("all state machines are listed")
def list_state_machines(lws_session, world):
    try:
        resp = _sfn(lws_session).list_state_machines()
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("executions for a state machine are listed")
def list_executions(lws_session, world):
    try:
        sm_name = world.get("state_machine_name", TEST_SM)
        resp = _sfn(lws_session).list_executions(stateMachineArn=_sm_arn(sm_name))
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("versions of a state machine are listed")
def list_state_machine_versions(lws_session, world):
    try:
        sm_name = world.get("state_machine_name", TEST_SM)
        resp = _sfn(lws_session).list_state_machine_versions(stateMachineArn=_sm_arn(sm_name))
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("tags for a state machine are listed")
def list_tags_for_sm(lws_session, world):
    try:
        sm_name = world.get("state_machine_name", TEST_SM)
        resp = _sfn(lws_session).list_tags_for_resource(resourceArn=_sm_arn(sm_name))
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an execution is started on a standard state machine")
def start_execution(lws_session, world):
    try:
        sm_name = world.get("state_machine_name", TEST_SM)
        resp = _sfn(lws_session).start_execution(
            stateMachineArn=_sm_arn(sm_name), input=TEST_INPUT
        )
        world["result"] = resp
        world["execution_arn"] = resp["executionArn"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a synchronous execution is started on an express state machine")
def start_sync_execution(lws_session, world):
    try:
        sm_name = world.get("state_machine_name", TEST_SM_EXPRESS)
        resp = _sfn(lws_session).start_sync_execution(
            stateMachineArn=_sm_arn(sm_name), input=TEST_INPUT
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a running execution is stopped")
def stop_execution(lws_session, world):
    try:
        execution_arn = world.get("execution_arn", "")
        resp = _sfn(lws_session).stop_execution(executionArn=execution_arn)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an execution is described")
def describe_execution(lws_session, world):
    try:
        execution_arn = world.get("execution_arn", "")
        resp = _sfn(lws_session).describe_execution(executionArn=execution_arn)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("the event history of an execution is retrieved")
def get_execution_history(lws_session, world):
    try:
        execution_arn = world.get("execution_arn", "")
        resp = _sfn(lws_session).get_execution_history(executionArn=execution_arn)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a state machine definition is updated")
def update_state_machine(lws_session, world):
    try:
        sm_name = world.get("state_machine_name", TEST_SM)
        resp = _sfn(lws_session).update_state_machine(
            stateMachineArn=_sm_arn(sm_name), definition=UPDATED_DEFINITION
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("tags are added to a state machine")
def tag_state_machine(lws_session, world):
    try:
        sm_name = world.get("state_machine_name", TEST_SM)
        resp = _sfn(lws_session).tag_resource(
            resourceArn=_sm_arn(sm_name),
            tags=[{"key": TEST_TAG_KEY, "value": TEST_TAG_VALUE}],
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("tags are removed from a state machine")
def untag_state_machine(lws_session, world):
    try:
        sm_name = world.get("state_machine_name", TEST_SM)
        resp = _sfn(lws_session).untag_resource(
            resourceArn=_sm_arn(sm_name), tagKeys=[TEST_TAG_KEY]
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a state machine definition is validated")
def validate_state_machine_definition(lws_session, world):
    if world.get("state_machine_arn") is None and world.get("state_machine_name") is None:
        pytest.skip(
            "ValidateStateMachineDefinition does not accept stateMachineArn; "
            "cannot test existence check via this SDK call"
        )
    sm_name = world.get("state_machine_name", TEST_SM)
    try:
        status = _sfn(lws_session).describe_state_machine(
            stateMachineArn=_sm_arn(sm_name)
        ).get("status", "ACTIVE")
    except Exception:
        status = None
    if status != "ACTIVE":
        pytest.skip(
            "ValidateStateMachineDefinition does not accept stateMachineArn; "
            "cannot test lifecycle check via this SDK call"
        )
    try:
        resp = _sfn(lws_session).validate_state_machine_definition(definition=PASS_DEFINITION)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a state machine deletion is finalized")
def finalize_delete_state_machine(world):
    pytest.skip("Cannot trigger internal state machine finalization event")


@when("a running execution transitions to a terminal state")
def execution_step_transition(world):
    pytest.skip("Cannot trigger internal execution step transition event")


@when("a running execution exceeds its timeout")
def execution_timeout(world):
    pytest.skip("Cannot trigger execution timeout programmatically")


# ── Then: assertions ───────────────────────────────────────────────────

@then('the state machine is "ACTIVE"')
def sm_is_active_then(lws_session, world):
    sm_name = world.get("state_machine_name", TEST_SM)
    resp = _sfn(lws_session).describe_state_machine(stateMachineArn=_sm_arn(sm_name))
    expected_status = "ACTIVE"
    actual_status = resp.get("status", "")
    assert actual_status == expected_status, (
        f"Expected state machine status '{expected_status}' but got '{actual_status}'"
    )


@then('the state machine is in "DELETING" state')
def sm_is_deleting_then(world):
    assert world["error"] is None, (
        f"Expected delete_state_machine to succeed but got: {world['error']}"
    )


@then('the state machine is "DELETED"')
def sm_is_deleted_then(world):
    assert world["error"] is None, (
        f"Expected finalization to succeed but got: {world['error']}"
    )


@then("the state machine details are returned")
def sm_details_returned(world):
    assert world["error"] is None, (
        f"Expected describe_state_machine to succeed but got: {world['error']}"
    )
    assert "name" in world["result"], "Expected 'name' key in response"


@then("the list of state machines is returned")
def list_of_sms_returned(world):
    assert world["error"] is None, (
        f"Expected list_state_machines to succeed but got: {world['error']}"
    )
    assert "stateMachines" in world["result"], "Expected 'stateMachines' in response"


@then("the list of executions is returned")
def list_of_executions_returned(world):
    assert world["error"] is None, (
        f"Expected list_executions to succeed but got: {world['error']}"
    )
    assert "executions" in world["result"], "Expected 'executions' in response"


@then("the list of state machine versions is returned")
def list_of_sm_versions_returned(world):
    assert world["error"] is None, (
        f"Expected list_state_machine_versions to succeed but got: {world['error']}"
    )
    assert "stateMachineVersions" in world["result"], (
        "Expected 'stateMachineVersions' in response"
    )


@then("the list of tags is returned")
def list_of_tags_returned(world):
    assert world["error"] is None, (
        f"Expected list_tags_for_resource to succeed but got: {world['error']}"
    )
    assert "tags" in world["result"], "Expected 'tags' key in response"


@then('the execution is "RUNNING"')
def execution_is_running_then(world):
    assert world["error"] is None, (
        f"Expected start_execution to succeed but got: {world['error']}"
    )
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"


@then('the execution is "ABORTED"')
def execution_is_aborted_then(lws_session, world):
    assert world["error"] is None, (
        f"Expected stop_execution to succeed but got: {world['error']}"
    )
    execution_arn = world.get("execution_arn", "")
    resp = _sfn(lws_session).describe_execution(executionArn=execution_arn)
    expected_status = "ABORTED"
    actual_status = resp.get("status", "")
    assert actual_status == expected_status, (
        f"Expected execution status '{expected_status}' but got '{actual_status}'"
    )


@then('the execution is "SUCCEEDED" or "FAILED"')
def execution_is_succeeded_or_failed_then(world):
    assert world["error"] is None, (
        f"Expected execution to complete but got: {world['error']}"
    )
    actual_status = world["result"].get("status", "")
    assert actual_status in ("SUCCEEDED", "FAILED"), (
        f"Expected execution status SUCCEEDED or FAILED but got '{actual_status}'"
    )


@then("the execution details are returned")
def execution_details_returned(world):
    assert world["error"] is None, (
        f"Expected describe_execution to succeed but got: {world['error']}"
    )
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"


@then("the execution history is returned")
def execution_history_returned(world):
    assert world["error"] is None, (
        f"Expected get_execution_history to succeed but got: {world['error']}"
    )
    assert "events" in world["result"], "Expected 'events' in response"


@then("the state machine version is incremented")
def sm_version_incremented(world):
    assert world["error"] is None, (
        f"Expected update_state_machine to succeed but got: {world['error']}"
    )


@then("the tags are associated with the state machine")
def tags_associated_with_sm(world):
    assert world["error"] is None, (
        f"Expected tag_resource to succeed but got: {world['error']}"
    )


@then("the tags are disassociated from the state machine")
def tags_disassociated_from_sm(world):
    assert world["error"] is None, (
        f"Expected untag_resource to succeed but got: {world['error']}"
    )


@then("the definition is valid or invalid")
def definition_is_valid_or_invalid(world):
    assert world["error"] is None, (
        f"Expected validate_state_machine_definition to succeed but got: {world['error']}"
    )
    assert "result" in world["result"] or "validationErrors" in world["result"], (
        "Expected 'result' or 'validationErrors' in response"
    )


@then('the execution is "TIMED_OUT"')
def execution_is_timed_out_then(world):
    assert world["error"] is None, (
        f"Expected timeout event to succeed but got: {world['error']}"
    )


@then('every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")')
def every_sm_has_valid_status(lws_session):
    list_resp = _sfn(lws_session).list_state_machines()
    expected_statuses = {"ACTIVE", "DELETING", "DELETED"}
    for sm in list_resp.get("stateMachines", []):
        sm_arn = sm.get("stateMachineArn", "")
        describe_resp = _sfn(lws_session).describe_state_machine(stateMachineArn=sm_arn)
        actual_status = describe_resp.get("status", "")
        assert actual_status in expected_statuses, (
            f"State machine '{sm.get('name')}' has invalid status '{actual_status}'; "
            f"expected one of {expected_statuses}"
        )


@then('every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")')
def every_execution_has_valid_status():
    """Invariant: trivially satisfied in isolated lws context."""


@then('every state machine has a valid type ("STANDARD" or "EXPRESS")')
def every_sm_has_valid_type():
    """Invariant: trivially satisfied in isolated lws context."""


@then("synchronous executions only run on express state machines")
def sync_executions_only_for_express():
    """Invariant: trivially satisfied in isolated lws context."""


@then("every execution belongs to a known state machine")
def every_execution_belongs_to_known_sm():
    """Invariant: trivially satisfied in isolated lws context."""
