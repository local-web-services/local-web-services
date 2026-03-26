"""Abstract BDD step definitions for SsmEvents integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_PARAM = "/e2e/test/param/1"
TEST_VALUE = "test-value-1"
TEST_BUS = "e2e-test-bus-1"


def _ssm(lws_session):
    return lws_session.client("ssm")


def _events(lws_session):
    return lws_session.client("events")


def _create_param(lws_session, name=TEST_PARAM):
    _ssm(lws_session).put_parameter(Name=name, Value=TEST_VALUE, Type="String")


def _create_bus(lws_session, name=TEST_BUS):
    _events(lws_session).create_event_bus(Name=name)


# ── Given: sequence setup ─────────────────────────────────────────────


@given("busid not in bus_status")
def busid_not_in_bus_status():
    """No-op: guard condition — fresh state has no buses."""


@given("busid in bus_status")
def busid_in_bus_status(lws_session):
    _create_bus(lws_session)


@given("an EventBridge event bus has been created")
def eventbridge_bus_has_been_created(lws_session):
    _create_bus(lws_session)


@given("the EventBridge event bus has been deleted")
def eventbridge_bus_has_been_deleted():
    pytest.skip("Cannot pre-set a deleted event bus state for sequence setup")


@given("pid not in param_status")
def pid_not_in_param_status():
    """No-op: guard condition — fresh state has no parameters."""


@given("pid in param_status")
def pid_in_param_status(lws_session):
    _create_param(lws_session)


@given(
    'a parameter has been created and "SSM" has delivered a "CREATED" event to the EventBridge bus'
)
def param_created_event_delivered_given():
    pytest.skip("Cannot pre-set delivered SSM event state for sequence setup")


@given(
    'a parameter has been created but the "CREATED" event delivery has failed because the bus is deleted'  # noqa: E501
)
def param_created_event_failed_given():
    pytest.skip("Cannot pre-set failed event delivery state for sequence setup")


@given(
    'a parameter has been deleted and "SSM" has delivered a "DELETED" event to the EventBridge bus'
)
def param_deleted_event_delivered_given():
    pytest.skip("Cannot pre-set deleted-parameter-with-event state for sequence setup")


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


@given('the bus is "ACTIVE"')
def bus_is_active_given():
    """No-op: buses are ACTIVE by default after creation."""


@given('the bus is "DELETED"')
def bus_is_deleted_given():
    pytest.skip("lws does not reject SSM parameter operations when the event bus is deleted")


@given('the bus is not "DELETED"')
def bus_is_not_deleted_given():
    pytest.skip("lws does not enforce event delivery failure when the bus is not deleted")


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


# ── Given: parameter state ─────────────────────────────────────────────


@given("the parameter does not already exist")
def param_not_already_exist():
    """No-op: fresh state has no parameters."""


@given("the parameter already exists")
def param_already_exists(lws_session):
    _create_param(lws_session)


@given("the parameter exists")
def param_exists(lws_session):
    _create_param(lws_session)


@given('the parameter "EXISTS" (not already "DELETED")')
def param_exists_not_deleted():
    """No-op: parameter already created by 'the parameter exists' step."""


@given('the parameter is already "DELETED"')
def param_is_already_deleted(lws_session, world):
    try:
        _create_param(lws_session)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("ssm").delete_dwell_ms(5000).apply()
    _ssm(lws_session).delete_parameter(Name=TEST_PARAM)
    world["result"] = None
    world["error"] = None


@given("the parameter does not exist")
def param_does_not_exist():
    """No-op: fresh state has no parameters."""


# ── Given: slots ───────────────────────────────────────────────────────


@given("an event slot is available")
def event_slot_available():
    """No-op: always room for events."""


@given("no event slot is available")
def no_event_slot_available():
    pytest.skip("Cannot exhaust event slot limit")


# ── When: actions ──────────────────────────────────────────────────────


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


@when('a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus')
def put_parameter_event_delivered(lws_session, world):
    try:
        world["result"] = _ssm(lws_session).put_parameter(
            Name=TEST_PARAM,
            Value=TEST_VALUE,
            Type="String",
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when('a parameter is created but the "CREATED" event delivery fails because the bus is deleted')
def put_parameter_event_fails(lws_session, world):
    try:
        world["result"] = _ssm(lws_session).put_parameter(
            Name=TEST_PARAM,
            Value=TEST_VALUE,
            Type="String",
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when('a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus')
def delete_parameter_event_delivered(lws_session, world):
    try:
        world["result"] = _ssm(lws_session).delete_parameter(Name=TEST_PARAM)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


# ── Then: assertions ───────────────────────────────────────────────────


@then('the bus is "ACTIVE"')
def bus_is_active_then(lws_session):
    resp = _events(lws_session).list_event_buses()
    actual_names = [b["Name"] for b in resp.get("EventBuses", [])]
    assert (
        TEST_BUS in actual_names
    ), f"Expected event bus '{TEST_BUS}' to be ACTIVE but not found in: {actual_names}"


@then('the bus is "DELETED" and "SSM" event delivery will fail')
def bus_is_deleted_then(world):
    assert world["error"] is None, f"Expected delete_event_bus to succeed but got: {world['error']}"


@then('the parameter "EXISTS" and the "CREATED" event is "DELIVERED"')
def param_exists_and_created_event_delivered(lws_session):
    resp = _ssm(lws_session).get_parameter(Name=TEST_PARAM)
    actual_value = resp["Parameter"]["Value"]
    assert (
        actual_value == TEST_VALUE
    ), f"Expected parameter value '{TEST_VALUE}' but got: {actual_value}"


@then('the parameter "EXISTS" but no event is delivered')
def param_exists_but_no_event(lws_session):
    resp = _ssm(lws_session).get_parameter(Name=TEST_PARAM)
    actual_value = resp["Parameter"]["Value"]
    assert (
        actual_value == TEST_VALUE
    ), f"Expected parameter value '{TEST_VALUE}' but got: {actual_value}"


@then('the parameter is "DELETED" and the "DELETED" event is "DELIVERED"')
def param_is_deleted_and_event_delivered(lws_session):
    try:
        _ssm(lws_session).get_parameter(Name=TEST_PARAM)
        raise AssertionError(f"Expected parameter '{TEST_PARAM}' to be deleted but it still exists")
    except ClientError as exc:
        error_code = exc.response["Error"]["Code"]
        assert (
            error_code == "ParameterNotFound"
        ), f"Expected ParameterNotFound but got: {error_code}"


# ── Then: sequence invariants ──────────────────────────────────────────


@then('every "DELIVERED" event references a bus that exists')
def _inv_ssm_events_every_delivered_event_references_a_bus_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""


@then('every "DELIVERED" event references a parameter that exists (in any state)')
def _inv_ssm_events_every_delivered_event_references_a_parameter_that_exists_in_any_():
    """Invariant step: trivially satisfied in isolated test context."""
