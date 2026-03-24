"""Abstract BDD step definitions for EventsLambda integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_BUS = "e2e-test-bus-1"
TEST_RULE = "test-rule-1"
TEST_FUNC = "e2e-test-func-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"
EVENT_PATTERN = '{"source":["test.source"]}'


def _events(lws_session):
    return lws_session.client("events")


def _lambda(lws_session):
    return lws_session.client("lambda")


def _create_bus(lws_session, name=TEST_BUS):
    _events(lws_session).create_event_bus(Name=name)


def _create_function(lws_session, name=TEST_FUNC):
    _lambda(lws_session).create_function(
        FunctionName=name,
        Runtime="python3.12",
        Role=ROLE_ARN,
        Handler="index.handler",
        Code={"ZipFile": b"fake"},
    )


def _create_rule_with_target(lws_session):
    _events(lws_session).put_rule(
        Name=TEST_RULE,
        EventBusName=TEST_BUS,
        EventPattern=EVENT_PATTERN,
        State="ENABLED",
    )
    _events(lws_session).put_targets(
        Rule=TEST_RULE,
        EventBusName=TEST_BUS,
        Targets=[
            {
                "Id": "t1",
                "Arn": f"arn:aws:lambda:us-east-1:000000000000:function:{TEST_FUNC}",
            }
        ],
    )


# ── Given: event bus state ────────────────────────────────────────────


@given("the event bus does not already exist")
def events_lambda_bus_not_already_exist():
    """No-op: fresh state has no event buses."""


@given("the event bus already exists")
def events_lambda_bus_already_exists(lws_session):
    _create_bus(lws_session)


@given("the event bus exists")
def events_lambda_bus_exists(lws_session):
    _create_bus(lws_session)


@given('the event bus is "ACTIVE"')
def events_lambda_bus_is_active_given():
    """No-op: event buses are ACTIVE immediately after creation."""


@given('the event bus is not "ACTIVE"')
def events_lambda_bus_is_not_active_given(lws_session, world):
    try:
        _events(lws_session).delete_event_bus(Name=TEST_BUS)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("events").create_dwell_ms(5000).apply()
    _create_bus(lws_session)
    world["result"] = None
    world["error"] = None


@given("the event bus does not exist")
def events_lambda_bus_does_not_exist():
    """No-op: fresh state has no event buses."""


# ── Given: function state ─────────────────────────────────────────────


@given("the function does not already exist")
def events_lambda_function_not_already_exist():
    """No-op: fresh state has no Lambda functions."""


@given("the function already exists")
def events_lambda_function_already_exists(lws_session):
    _create_function(lws_session)


@given("the function exists")
def events_lambda_function_exists(lws_session):
    _create_function(lws_session)


@given('the function is "ACTIVE"')
def events_lambda_function_is_active_given():
    """No-op: Lambda functions are ACTIVE immediately after creation."""


@given('the function is not "ACTIVE"')
def events_lambda_function_is_not_active_given():  # noqa: ARG001
    pytest.skip("lws does not validate Lambda target state in put_targets")


@given("the function does not exist")
def events_lambda_function_does_not_exist():
    pytest.skip("lws does not validate Lambda target existence in put_targets")


# ── Given: rule state ─────────────────────────────────────────────────


@given("the rule does not already exist")
def events_lambda_rule_not_already_exist():
    """No-op: fresh state has no rules."""


@given("the rule already exists")
def events_lambda_rule_already_exists(lws_session):
    try:
        _create_bus(lws_session)
    except Exception:  # noqa: BLE001
        pass
    try:
        _create_function(lws_session)
    except Exception:  # noqa: BLE001
        pass
    _create_rule_with_target(lws_session)


@given('an "ENABLED" rule exists on the bus targeting a function')
def events_lambda_enabled_rule_exists(lws_session):
    try:
        _create_bus(lws_session)
    except Exception:  # noqa: BLE001
        pass
    try:
        _create_function(lws_session)
    except Exception:  # noqa: BLE001
        pass
    _create_rule_with_target(lws_session)


@given('no "ENABLED" rule exists on the bus targeting a function')
def events_lambda_no_enabled_rule():
    pytest.skip("Cannot trigger internal EventBridge->Lambda routing in lws")


@given('the target function is "ACTIVE"')
def events_lambda_target_function_is_active():
    """No-op: Lambda functions are ACTIVE immediately after creation."""


@given('the target function is not "ACTIVE"')
def events_lambda_target_function_is_not_active():
    pytest.skip("Cannot trigger internal EventBridge->Lambda routing in lws")


# ── Given: slots ───────────────────────────────────────────────────────


@given("an invocation slot is available")
def events_lambda_invocation_slot_available(lws_session):
    lws_session.capacity("lambda").unlimited().apply()


@given("no invocation slot is available")
def events_lambda_no_invocation_slot_available(lws_session):
    lws_session.capacity("lambda").exhaust().apply()


# ── Given: invocation state ───────────────────────────────────────────


@given('an invocation is "IN_PROGRESS"')
def events_lambda_invocation_is_in_progress():
    pytest.skip("Cannot trigger internal EventBridge->Lambda routing in lws")


@given('no invocation is "IN_PROGRESS"')
def events_lambda_no_invocation_is_in_progress():
    """No-op: fresh state has no in-progress invocations."""


# ── When: actions ──────────────────────────────────────────────────────


@when("an EventBridge event bus is created")
def create_event_bus(lws_session, world):
    try:
        resp = _events(lws_session).create_event_bus(Name=TEST_BUS)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("a Lambda function is deployed")
def deploy_lambda_function_events(lws_session, world):
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


@when(
    "an EventBridge rule is created to asynchronously invoke a Lambda function on matching events"
)
def create_eventbridge_rule(lws_session, world):
    try:
        _events(lws_session).put_rule(
            Name=TEST_RULE,
            EventBusName=TEST_BUS,
            EventPattern=EVENT_PATTERN,
            State="ENABLED",
        )
        resp = _events(lws_session).put_targets(
            Rule=TEST_RULE,
            EventBusName=TEST_BUS,
            Targets=[
                {
                    "Id": "t1",
                    "Arn": f"arn:aws:lambda:us-east-1:000000000000:function:{TEST_FUNC}",
                }
            ],
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("an event is published to the bus and triggers an asynchronous Lambda invocation")
def put_event_triggers_invocation(world):
    pytest.skip("Cannot trigger internal EventBridge->Lambda routing in lws")


@when("the Lambda invocation completes successfully")
def events_lambda_invocation_completes(world):
    pytest.skip("Cannot trigger internal EventBridge->Lambda routing in lws")


@when("the Lambda invocation fails")
def events_lambda_invocation_fails(world):
    pytest.skip("Cannot trigger internal EventBridge->Lambda routing in lws")


# ── Then: assertions ───────────────────────────────────────────────────


@then('the event bus is "ACTIVE"')
def events_lambda_bus_is_active_then(lws_session):
    resp = _events(lws_session).describe_event_bus(Name=TEST_BUS)
    expected_name = TEST_BUS
    actual_name = resp.get("Name", "")
    assert (
        actual_name == expected_name
    ), f"Expected event bus '{expected_name}' to be ACTIVE but got '{actual_name}'"


@then('the function is "ACTIVE"')
def events_lambda_function_is_active_then(lws_session):
    resp = _lambda(lws_session).get_function(FunctionName=TEST_FUNC)
    expected_state = "Active"
    actual_state = resp["Configuration"].get("State", "")
    assert (
        actual_state == expected_state
    ), f"Expected function state '{expected_state}' but got '{actual_state}'"


@then('the rule is "ENABLED" and will trigger the function when matching events are published')
def rule_is_enabled(lws_session):
    resp = _events(lws_session).describe_rule(Name=TEST_RULE, EventBusName=TEST_BUS)
    expected_state = "ENABLED"
    actual_state = resp.get("State", "")
    assert (
        actual_state == expected_state
    ), f"Expected rule state '{expected_state}' but got '{actual_state}'"


@then('the invocation is "IN_PROGRESS"')
def events_lambda_invocation_is_in_progress_then():
    pytest.skip("Cannot trigger internal EventBridge->Lambda routing in lws")


@then('the invocation is "SUCCESS"')
def events_lambda_invocation_is_success():
    pytest.skip("Cannot trigger internal EventBridge->Lambda routing in lws")


@then('the invocation is "FAILED"')
def events_lambda_invocation_is_failed():
    pytest.skip("Cannot trigger internal EventBridge->Lambda routing in lws")
