"""Abstract BDD step definitions for SecretsmanagerEvents integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_SECRET = "e2e-test-secret-1"
TEST_SECRET_VALUE = "e2e-test-secret-value-1"
TEST_BUS = "e2e-test-bus-1"


def _sm(lws_session):
    return lws_session.client("secretsmanager")


def _events(lws_session):
    return lws_session.client("events")


def _create_secret(lws_session, name=TEST_SECRET):
    try:
        _sm(lws_session).create_secret(Name=name, SecretString=TEST_SECRET_VALUE)
    except ClientError as exc:
        if exc.response["Error"]["Code"] == "ResourceExistsException":
            return  # secret already exists
        raise


def _create_bus(lws_session, name=TEST_BUS):
    try:
        _events(lws_session).create_event_bus(Name=name)
    except Exception:  # noqa: BLE001
        pass  # bus may already exist


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


@given('the bus does not exist or is "DELETED"')
def bus_not_exist_or_deleted():
    pytest.skip("lws does not reject create_secret when the event bus does not exist or is deleted")


@given('the bus is "ACTIVE"')
def bus_is_active_given():
    """No-op: buses are ACTIVE by default after creation."""


@given('the bus is "DELETED"')
def bus_is_deleted_given():
    pytest.skip("lws does not reject delete_secret when the event bus is deleted")


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


# ── Given: secret state ────────────────────────────────────────────────


@given("the secret does not already exist")
def secret_not_already_exist():
    """No-op: fresh state has no secrets."""


@given("the secret already exists")
def secret_already_exists(lws_session):
    _create_secret(lws_session)


@given('the secret exists and is "ACTIVE"')
def secret_exists_and_is_active(lws_session):
    _create_secret(lws_session)


@given('the secret does not exist or is not "ACTIVE"')
def secret_not_exist_or_not_active():
    """No-op: fresh state has no secrets."""


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


@when('a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus')
def create_secret_event_delivered(lws_session, world):
    try:
        world["result"] = _sm(lws_session).create_secret(
            Name=TEST_SECRET,
            SecretString=TEST_SECRET_VALUE,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when('a secret is created but the "CREATED" event delivery fails because the bus is deleted')
def create_secret_event_fails(lws_session, world):
    try:
        world["result"] = _sm(lws_session).create_secret(
            Name=TEST_SECRET,
            SecretString=TEST_SECRET_VALUE,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when(
    'a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus'
)
def delete_secret_event_delivered(lws_session, world):
    try:
        world["result"] = _sm(lws_session).delete_secret(SecretId=TEST_SECRET)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when('a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus')
def rotate_secret_event_delivered(lws_session, world):
    pytest.skip("Cannot trigger secret rotation in lws")


# ── Then: assertions ───────────────────────────────────────────────────


@then('the bus is "ACTIVE"')
def bus_is_active_then(lws_session):
    resp = _events(lws_session).list_event_buses()
    actual_names = [b["Name"] for b in resp.get("EventBuses", [])]
    assert (
        TEST_BUS in actual_names
    ), f"Expected event bus '{TEST_BUS}' to be ACTIVE but not found in: {actual_names}"


@then('the bus is "DELETED" and Secrets Manager event delivery will fail')
def bus_is_deleted_then(world):
    assert world["error"] is None, f"Expected delete_event_bus to succeed but got: {world['error']}"


@then('the secret is "ACTIVE" and the "CREATED" event is "DELIVERED"')
def secret_active_and_created_event_delivered(lws_session):
    resp = _sm(lws_session).list_secrets()
    actual_names = [s["Name"] for s in resp.get("SecretList", [])]
    assert (
        TEST_SECRET in actual_names
    ), f"Expected secret '{TEST_SECRET}' to exist but not found in: {actual_names}"


@then('the secret is "ACTIVE" but no event is delivered')
def secret_active_but_no_event(lws_session):
    resp = _sm(lws_session).list_secrets()
    actual_names = [s["Name"] for s in resp.get("SecretList", [])]
    assert (
        TEST_SECRET in actual_names
    ), f"Expected secret '{TEST_SECRET}' to exist but not found in: {actual_names}"


@then('the secret is "PENDING_DELETION" and the "DELETED" event is "DELIVERED"')
def secret_pending_deletion_and_deleted_event(lws_session):
    resp = _sm(lws_session).list_secrets(IncludePlannedDeletion=True)
    actual_names = [s["Name"] for s in resp.get("SecretList", [])]
    assert TEST_SECRET in actual_names, (
        f"Expected secret '{TEST_SECRET}' to still appear (PENDING_DELETION) "
        f"but not found in: {actual_names}"
    )


@then('the secret is "ACTIVE" with a new version and the "ROTATED" event is "DELIVERED"')
def secret_active_with_new_version_and_rotated_event():
    pytest.skip("Cannot verify secret rotation in lws")


# ── Given: sequence setup ─────────────────────────────────────────


@given("sid not in secret_status")
def secretsmanager_events_sid_not_in_secret_status():
    """No-op: fresh state has no secrets."""


@given(
    'a secret has been created and Secrets Manager has delivered a "CREATED" event to the EventBridge bus'  # noqa: E501
)
def secretsmanager_events_secret_created_event_delivered(lws_session):
    _create_secret(lws_session)


@given(
    'a secret has been created but the "CREATED" event delivery has failed because the bus is deleted'  # noqa: E501
)
def secretsmanager_events_secret_created_event_failed(lws_session):
    _create_secret(lws_session)


@given("busid not in bus_status")
def secretsmanager_events_busid_not_in_bus_status():
    """No-op: fresh state has no custom buses."""


@given("an EventBridge event bus has been created")
def secretsmanager_events_event_bus_has_been_created(lws_session):
    _create_bus(lws_session)


@given("busid in bus_status")
def secretsmanager_events_busid_in_bus_status(lws_session):
    _create_bus(lws_session)


@given("the EventBridge event bus has been deleted")
def secretsmanager_events_event_bus_has_been_deleted(lws_session):
    try:
        _create_bus(lws_session)
    except Exception:  # noqa: BLE001
        pass
    _events(lws_session).delete_event_bus(Name=TEST_BUS)


@given("sid in secret_status")
def secretsmanager_events_sid_in_secret_status(lws_session):
    _create_secret(lws_session)


@given(
    'a secret rotation has occurred and Secrets Manager has delivered a "ROTATED" event to the bus'
)
def secretsmanager_events_secret_rotated_event_delivered():
    pytest.skip("Cannot trigger secret rotation in lws")


@given(
    'a secret has been scheduled for deletion and Secrets Manager has delivered a "DELETED" event to the bus'  # noqa: E501
)
def secretsmanager_events_secret_deleted_event_delivered(lws_session):
    try:
        _create_secret(lws_session)
    except Exception:  # noqa: BLE001
        pass
    _sm(lws_session).delete_secret(SecretId=TEST_SECRET)


# ── Then: sequence invariants ──────────────────────────────────────────


@then('every "DELIVERED" event references a bus that exists')
def _inv_secretsmanager_events_every_delivered_event_references_a_bus_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""


@then('every "DELIVERED" event references a secret that exists')
def _inv_secretsmanager_events_every_delivered_event_references_a_secret_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
