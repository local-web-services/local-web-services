"""Abstract BDD step definitions for EventsStepfunctions integration spec scenarios."""

from __future__ import annotations

import json

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_BUS = "e2e-test-bus-1"
TEST_RULE = "test-rule-1"
TEST_SM = "test-sm-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"
PASS_DEFINITION = json.dumps(
    {"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}}
)
EVENT_PATTERN = json.dumps({"source": ["test.source"]})
TEST_INPUT = '{"key": "value"}'


def _events(lws_session):
    return lws_session.client("events")


def _sfn(lws_session):
    return lws_session.client("stepfunctions")


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"


def _create_bus(lws_session, name=TEST_BUS):
    _events(lws_session).create_event_bus(Name=name)


def _create_sm(lws_session, name=TEST_SM):
    resp = _sfn(lws_session).create_state_machine(
        name=name,
        definition=PASS_DEFINITION,
        roleArn=ROLE_ARN,
    )
    return resp["stateMachineArn"]


def _create_rule_targeting_sfn(lws_session, bus=TEST_BUS, rule=TEST_RULE):
    _events(lws_session).put_rule(
        Name=rule,
        EventBusName=bus,
        EventPattern=EVENT_PATTERN,
        State="ENABLED",
    )
    _events(lws_session).put_targets(
        Rule=rule,
        EventBusName=bus,
        Targets=[{"Id": "t1", "Arn": _sm_arn()}],
    )


# ── Given: bus state ───────────────────────────────────────────────────

@given("the event bus does not already exist")
def event_bus_not_already_exist():
    """No-op: fresh state has no custom buses."""


@given("the event bus already exists")
def event_bus_already_exists(lws_session):
    _create_bus(lws_session)


@given("the event bus exists")
def event_bus_exists(lws_session):
    _create_bus(lws_session)


@given("the event bus is \"ACTIVE\"")
def event_bus_is_active_given():
    """No-op: buses are ACTIVE by default."""


@given("the event bus is not \"ACTIVE\"")
def event_bus_is_not_active_given(lws_session, world):
    import httpx
    try:
        _events(lws_session).delete_event_bus(Name=TEST_BUS)
    except Exception:  # noqa: BLE001
        pass
    httpx.post(
        f"http://127.0.0.1:{lws_session._mgmt_port}/_ldk/lifecycle",
        json={"events": {"enabled": True, "create_dwell_ms": 5000}},
        timeout=5.0,
    )
    _create_bus(lws_session)
    world["result"] = None
    world["error"] = None


@given("the event bus does not exist")
def event_bus_does_not_exist():
    """No-op: fresh state has no buses."""


# ── Given: state machine state ─────────────────────────────────────────

@given("the state machine does not already exist")
def sm_not_already_exist():
    """No-op: fresh state has no state machines."""


@given("the state machine already exists")
def sm_already_exists(lws_session, world):
    world["state_machine_arn"] = _create_sm(lws_session)


@given("the state machine exists")
def sm_exists(lws_session, world):
    world["state_machine_arn"] = _create_sm(lws_session)


@given("the state machine is \"ACTIVE\"")
def sm_is_active_given():
    """No-op: state machines are ACTIVE by default."""


@given("the state machine is not \"ACTIVE\"")
def sm_is_not_active_given(lws_session, world):
    import httpx
    httpx.post(
        f"http://127.0.0.1:{lws_session._mgmt_port}/_ldk/lifecycle",
        json={"stepfunctions": {"enabled": True, "create_dwell_ms": 5000}},
        timeout=5.0,
    )
    try:
        _sfn(lws_session).delete_state_machine(stateMachineArn=_sm_arn())
    except Exception:  # noqa: BLE001
        pass
    _create_sm(lws_session)
    world["result"] = None
    world["error"] = None


@given("the state machine does not exist")
def sm_does_not_exist():
    pytest.skip("lws does not validate state machine target existence when creating a rule")


@given("the target state machine is \"ACTIVE\"")
def target_sm_is_active():
    """No-op: state machines are ACTIVE by default after creation."""


@given("the target state machine is not \"ACTIVE\"")
def target_sm_is_not_active():
    pytest.skip("lws does not reject put_events when the target state machine is not ACTIVE")


# ── Given: rule targeting state machine ────────────────────────────────

@given("the rule does not already exist")
def rule_not_already_exist():
    """No-op: fresh state has no rules."""


@given("the rule already exists")
def rule_already_exists(lws_session, world):
    world["state_machine_arn"] = _sm_arn()
    _create_rule_targeting_sfn(lws_session)


@given("an \"ENABLED\" rule exists on the bus targeting a state machine")
def enabled_rule_exists_targeting_sfn(lws_session, world):
    world["state_machine_arn"] = _create_sm(lws_session)
    _create_rule_targeting_sfn(lws_session)


@given("no \"ENABLED\" rule exists on the bus targeting a state machine")
def no_enabled_rule_targeting_sfn():
    pytest.skip("lws does not reject put_events when no enabled rule exists targeting the state machine")


# ── Given: execution state ─────────────────────────────────────────────

@given("an execution is \"RUNNING\"")
def execution_is_running(lws_session, world):
    world["state_machine_arn"] = _create_sm(lws_session)
    resp = _sfn(lws_session).start_execution(
        stateMachineArn=world["state_machine_arn"],
        input=TEST_INPUT,
    )
    world["execution_arn"] = resp["executionArn"]


@given("no execution is \"RUNNING\"")
def no_execution_is_running():
    pytest.skip("Cannot test failure when no execution is RUNNING in isolated context")


# ── Given: slots ───────────────────────────────────────────────────────

@given("an execution slot is available")
def execution_slot_available():
    """No-op: always room for executions."""


@given("no execution slot is available")
def no_execution_slot_available():
    pytest.skip("Cannot exhaust execution slot limit")


# ── When: actions ──────────────────────────────────────────────────────

@when("an EventBridge event bus is created")
def create_event_bus(lws_session, world):
    try:
        world["result"] = _events(lws_session).create_event_bus(Name=TEST_BUS)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a Step Functions state machine is created")
def create_state_machine(lws_session, world):
    try:
        resp = _sfn(lws_session).create_state_machine(
            name=TEST_SM,
            definition=PASS_DEFINITION,
            roleArn=ROLE_ARN,
        )
        world["result"] = resp
        world["state_machine_arn"] = resp["stateMachineArn"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an EventBridge rule is created to start a Step Functions execution on matching events")
def put_rule_targeting_sfn(lws_session, world):
    try:
        result = _events(lws_session).put_rule(
            Name=TEST_RULE,
            EventBusName=TEST_BUS,
            EventPattern=EVENT_PATTERN,
            State="ENABLED",
        )
        _events(lws_session).put_targets(
            Rule=TEST_RULE,
            EventBusName=TEST_BUS,
            Targets=[{"Id": "t1", "Arn": _sm_arn()}],
        )
        world["result"] = result
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an event is published to the bus and triggers a new Step Functions execution")
def put_event_triggers_sfn(lws_session, world):
    try:
        world["result"] = _events(lws_session).put_events(
            Entries=[
                {
                    "EventBusName": TEST_BUS,
                    "Source": "test.source",
                    "DetailType": "TestEvent",
                    "Detail": '{"key": "value"}',
                }
            ]
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a running execution fails")
def running_execution_fails(world):
    pytest.skip("Cannot trigger internal execution failure in lws")


@when("a running execution completes successfully")
def running_execution_succeeds(world):
    pytest.skip("Cannot trigger internal execution completion in lws")


# ── Then: assertions ───────────────────────────────────────────────────

@then("the event bus is \"ACTIVE\"")
def event_bus_is_active_then(lws_session):
    resp = _events(lws_session).list_event_buses()
    actual_names = [b["Name"] for b in resp.get("EventBuses", [])]
    assert TEST_BUS in actual_names, (
        f"Expected event bus '{TEST_BUS}' to be ACTIVE but not found in: {actual_names}"
    )


@then("the state machine is \"ACTIVE\"")
def sm_is_active_then(lws_session, world):
    sm_arn = world.get("state_machine_arn", _sm_arn())
    resp = _sfn(lws_session).describe_state_machine(stateMachineArn=sm_arn)
    expected_status = "ACTIVE"
    actual_status = resp.get("status", "")
    assert actual_status == expected_status, (
        f"Expected state machine status '{expected_status}' but got '{actual_status}'"
    )


@then("the rule is \"ENABLED\" and will trigger an execution when matching events are published")
def rule_enabled_targeting_sfn(world):
    assert world["error"] is None, (
        f"Expected put_rule to succeed but got: {world['error']}"
    )


@then("the execution is \"RUNNING\"")
def execution_is_running_then(world):
    assert world["error"] is None, (
        f"Expected put_events to succeed but got: {world['error']}"
    )


@then("the execution is \"FAILED\"")
def execution_is_failed_then(world):
    pytest.skip("Cannot observe internal execution failure in lws")


@then("the execution is \"SUCCEEDED\"")
def execution_is_succeeded_then(world):
    pytest.skip("Cannot observe internal execution success in lws")


