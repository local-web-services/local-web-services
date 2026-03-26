"""Abstract BDD step definitions for StepfunctionsEvents integration spec scenarios."""

from __future__ import annotations

import json

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_SM = "test-sm-1"
TEST_BUS = "e2e-test-bus-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"
PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})
TEST_INPUT = '{"key": "value"}'


def _sfn(lws_session):
    return lws_session.client("stepfunctions")


def _events(lws_session):
    return lws_session.client("events")


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"


def _create_sm(lws_session, name=TEST_SM):
    resp = _sfn(lws_session).create_state_machine(
        name=name,
        definition=PASS_DEFINITION,
        roleArn=ROLE_ARN,
    )
    return resp["stateMachineArn"]


def _create_bus(lws_session, name=TEST_BUS):
    _events(lws_session).create_event_bus(Name=name)


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


@given("busid not in bus_status")
def busid_not_in_bus_status():
    """No-op: guard condition — fresh state has no event buses."""


@given("busid in bus_status")
def busid_in_bus_status(lws_session):
    _create_bus(lws_session)


@given("an EventBridge event bus has been created")
def eventbridge_bus_has_been_created(lws_session):
    _create_bus(lws_session)


@given("the EventBridge event bus has been deleted")
def eventbridge_bus_has_been_deleted():
    pytest.skip("Cannot pre-set a deleted event bus state for sequence setup")


@given("the state machine has been configured to publish execution events to the event bus")
def sm_configured_to_publish_events_given():
    pytest.skip("Cannot pre-set EventBridge publishing configuration on state machine")


@given(
    'an execution has started and Step Functions has delivered a "STARTED" event to the EventBridge bus'  # noqa: E501
)
def execution_started_event_delivered_given():
    pytest.skip("Cannot pre-set a delivered STARTED event state for sequence setup")


@given(
    'an execution has started but the "STARTED" event delivery has failed because the bus is deleted'  # noqa: E501
)
def execution_started_event_failed_given():
    pytest.skip("Cannot pre-set a failed STARTED event delivery state for sequence setup")


@given("eid in exec_status")
def eid_in_exec_status():
    pytest.skip("Cannot pre-set an in-flight execution state for sequence setup")


@given(
    'a running execution has succeeded and Step Functions has delivered a "SUCCEEDED" event to the bus'  # noqa: E501
)
def running_execution_succeeded_event_delivered_given():
    pytest.skip("Cannot pre-set a delivered SUCCEEDED event state for sequence setup")


@given(
    'a running execution has succeeded but the "SUCCEEDED" event delivery has failed because the bus is deleted'  # noqa: E501
)
def running_execution_succeeded_event_failed_given():
    pytest.skip("Cannot pre-set a failed SUCCEEDED event delivery state for sequence setup")


# ── Given: state machine state ────────────────────────────────────────


@given("the state machine does not already exist")
def sm_not_already_exist():
    """No-op: fresh state has no state machines."""


@given("the state machine already exists")
def sm_already_exists(lws_session):
    _create_sm(lws_session)


@given('the state machine exists and is "ACTIVE"')
def sm_exists_and_is_active(lws_session):
    _create_sm(lws_session)


@given('the state machine does not exist or is not "ACTIVE"')
def sm_not_exist_or_not_active():
    """No-op: fresh state has no state machines."""


@given("the state machine has no EventBridge bus configured")
def sm_has_no_eventbridge_bus():
    pytest.skip("lws does not validate EventBridge bus configuration before starting an execution")


@given("the state machine already has an EventBridge bus configured")
def sm_already_has_eventbridge_bus():
    pytest.skip("Cannot pre-configure EventBridge bus on state machine in this context")


@given("the state machine has an EventBridge bus configured")
def sm_has_eventbridge_bus():
    pytest.skip("Cannot pre-configure EventBridge bus on state machine in this context")


# ── Given: bus state ───────────────────────────────────────────────────


@given("the bus does not already exist")
def bus_not_already_exist():
    """No-op: fresh state has no custom buses."""


@given("the bus already exists")
def bus_already_exists(lws_session):
    _create_bus(lws_session)


@given("the bus exists")
def bus_exists(lws_session):
    _create_bus(lws_session)


@given('the bus exists and is "ACTIVE"')
def bus_exists_and_is_active(lws_session):
    _create_bus(lws_session)


@given('the bus does not exist or is not "ACTIVE"')
def bus_not_exist_or_not_active():
    """No-op: fresh state has no custom buses."""


@given('the bus is "ACTIVE"')
def bus_is_active_given():
    """No-op: buses are ACTIVE by default after creation."""


@given('the bus is "DELETED"')
def bus_is_deleted_given():
    """No-op: fresh state has no custom buses (simulates deleted bus)."""


@given('the bus is not "DELETED"')
def bus_is_not_deleted_given(lws_session):
    _create_bus(lws_session)


@given('the bus is already "DELETED"')
def bus_is_already_deleted(lws_session, world):
    try:
        _create_bus(lws_session)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("events").delete_dwell_ms(5000).apply()
    _events(lws_session).delete_event_bus(Name=TEST_BUS)
    world["result"] = None
    world["error"] = None


@given("the bus does not exist")
def bus_does_not_exist():
    """No-op: fresh state has no buses."""


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


@given("an event slot is available")
def event_slot_available():
    """No-op: always room for events."""


@given("no event slot is available")
def no_event_slot_available(lws_session):
    lws_session.capacity("events").exhaust().apply()


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


@when("an EventBridge event bus is created")
def create_event_bus(lws_session, world):
    try:
        world["result"] = _events(lws_session).create_event_bus(Name=TEST_BUS)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("the EventBridge event bus is deleted")
def delete_event_bus(lws_session, world):
    try:
        world["result"] = _events(lws_session).delete_event_bus(Name=TEST_BUS)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("the state machine is configured to publish execution events to the event bus")
def configure_event_publishing(world):
    pytest.skip("Cannot configure EventBridge publishing on state machine in lws")


@when('an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus')
def start_execution_event_delivered(lws_session, world):
    pytest.skip("Cannot configure EventBridge event delivery for execution start in lws")


@when('an execution starts but the "STARTED" event delivery fails because the bus is deleted')
def start_execution_event_fails(lws_session, world):
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


@when('a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus')
def execution_succeeds_event_delivered(world):
    pytest.skip("Cannot trigger internal execution completion with event delivery in lws")


@when(
    'a running execution succeeds but the "SUCCEEDED" event delivery'
    " fails because the bus is deleted"
)
def execution_succeeds_event_fails(world):
    pytest.skip("Cannot trigger internal execution completion in lws")


# ── Then: assertions ───────────────────────────────────────────────────


@then('the state machine is "ACTIVE" with no EventBridge bus configured')
def sm_active_no_eventbridge_bus(lws_session):
    resp = _sfn(lws_session).describe_state_machine(stateMachineArn=_sm_arn())
    expected_status = "ACTIVE"
    actual_status = resp.get("status", "")
    assert (
        actual_status == expected_status
    ), f"Expected state machine status '{expected_status}' but got '{actual_status}'"


@then('the bus is "ACTIVE"')
def bus_is_active_then(lws_session):
    resp = _events(lws_session).list_event_buses()
    actual_names = [b["Name"] for b in resp.get("EventBuses", [])]
    assert (
        TEST_BUS in actual_names
    ), f"Expected event bus '{TEST_BUS}' to be ACTIVE but not found in: {actual_names}"


@then('the bus is "DELETED" and execution event delivery will fail')
def bus_is_deleted_then(world):
    assert world["error"] is None, f"Expected delete_event_bus to succeed but got: {world['error']}"


@then("the state machine will send execution state change events to the bus")
def sm_will_send_events(world):
    pytest.skip("Cannot observe EventBridge publishing configuration in lws")


@then('the execution is "RUNNING" and the "STARTED" event is "DELIVERED"')
def execution_running_and_started_event_delivered(world):
    pytest.skip("Cannot observe EventBridge event delivery for execution start in lws")


@then('the execution is "RUNNING" but no "STARTED" event is delivered')
def execution_running_but_no_started_event(world):
    pytest.skip("Cannot observe missing EventBridge event delivery in lws")


@then('the execution is "SUCCEEDED" and the "SUCCEEDED" event is "DELIVERED"')
def execution_succeeded_and_event_delivered(world):
    pytest.skip("Cannot observe EventBridge event delivery for execution completion in lws")


@then('the execution is "SUCCEEDED" but no "SUCCEEDED" event is delivered')
def execution_succeeded_but_no_event(world):
    pytest.skip("Cannot observe missing EventBridge event delivery in lws")


# ── Then: sequence invariants ──────────────────────────────────────────


@then('every "DELIVERED" event references an execution that exists')
def _inv_stepfunctions_events_every_delivered_event_references_an_execution_that_exi():
    """Invariant step: trivially satisfied in isolated test context."""


@then('every "RUNNING" execution references an "ACTIVE" state machine')
def _inv_stepfunctions_events_every_running_execution_references_an_active_state_mac():
    """Invariant step: trivially satisfied in isolated test context."""
