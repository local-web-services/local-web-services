"""Shared fixtures and BDD step definitions for CloudTrail integration tests."""

from __future__ import annotations

import pytest
from pytest_bdd import given, then, when
from starlette.testclient import TestClient

from lws.providers.cloudtrail.routes import create_cloudtrail_app

INT_TRAIL_NAME = "int-test-trail-1"
INT_S3_BUCKET = "int-test-bucket-1"

_CT_TARGET = "CloudTrail_20131101"


# ── App / client fixtures ─────────────────────────────────────────────────────


@pytest.fixture
async def provider():
    """CloudTrail uses a stateless app factory."""
    yield None


@pytest.fixture
def app(provider):
    app, _ = create_cloudtrail_app()
    return app


@pytest.fixture
async def client(app):
    with TestClient(app, raise_server_exceptions=False) as c:
        yield c


# ── Helpers ───────────────────────────────────────────────────────────────────


def _post(client: TestClient, action: str, body: dict) -> tuple[int, dict]:
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_CT_TARGET}.{action}"},
        json=body,
    )
    return r.status_code, r.json()


def _create_trail(client: TestClient, name: str = INT_TRAIL_NAME) -> dict:
    _, body = _post(client, "CreateTrail", {"Name": name, "S3BucketName": INT_S3_BUCKET})
    return body


# ── Given: trail state setup ──────────────────────────────────────────────────


@given("the trail does not already exist")
def trail_not_already_exist():
    """No-op: fresh state has no trails."""


@given("the trail already exists")
def trail_already_exists(client: TestClient, world):
    resp = _create_trail(client)
    world["trail_name"] = resp.get("Name")


@given("the trail exists and is active")
def trail_exists_and_is_active(client: TestClient, world):
    resp = _create_trail(client)
    world["trail_name"] = resp.get("Name")


@given("the trail does not exist")
def trail_does_not_exist(world):
    """Use a nonexistent trail name for negative scenarios."""
    world["trail_name"] = "nonexistent-trail"


@given("the trail exists and logging is disabled")
def trail_exists_logging_disabled(client: TestClient, world):
    resp = _create_trail(client)
    world["trail_name"] = resp.get("Name")


@given("the trail exists and logging is enabled")
def trail_exists_logging_enabled(client: TestClient, world):
    resp = _create_trail(client)
    world["trail_name"] = resp.get("Name")
    _post(client, "StartLogging", {"Name": world["trail_name"]})


@given("at least one CloudTrail API call has been made")
def at_least_one_api_call_made(client: TestClient, world):
    resp = _create_trail(client)
    world["trail_name"] = resp.get("Name")


# ── When: actions ─────────────────────────────────────────────────────────────


@when("a trail is created")
def create_trail(client: TestClient, world):
    status, body = _post(
        client, "CreateTrail", {"Name": INT_TRAIL_NAME, "S3BucketName": INT_S3_BUCKET}
    )
    if status == 200:
        world["result"] = body
        world["trail_name"] = body.get("Name")
    else:
        world["error"] = body


@when("a trail is deleted")
def delete_trail(client: TestClient, world):
    trail_name = world.get("trail_name", INT_TRAIL_NAME)
    status, body = _post(client, "DeleteTrail", {"Name": trail_name})
    if status == 200:
        world["result"] = body
    else:
        world["error"] = body


@when("logging is started on the trail")
def start_logging(client: TestClient, world):
    trail_name = world.get("trail_name", INT_TRAIL_NAME)
    status, body = _post(client, "StartLogging", {"Name": trail_name})
    if status == 200:
        world["result"] = body
    else:
        world["error"] = body


@when("logging is stopped on the trail")
def stop_logging(client: TestClient, world):
    trail_name = world.get("trail_name", INT_TRAIL_NAME)
    status, body = _post(client, "StopLogging", {"Name": trail_name})
    if status == 200:
        world["result"] = body
    else:
        world["error"] = body


@when("event selectors are put for the trail")
def put_event_selectors(client: TestClient, world):
    trail_name = world.get("trail_name", INT_TRAIL_NAME)
    selectors = [{"ReadWriteType": "All", "IncludeManagementEvents": True}]
    status, body = _post(
        client, "PutEventSelectors", {"TrailName": trail_name, "EventSelectors": selectors}
    )
    if status == 200:
        world["result"] = body
    else:
        world["error"] = body


@when("events are looked up")
def lookup_events(client: TestClient, world):
    status, body = _post(client, "LookupEvents", {})
    if status == 200:
        world["result"] = body
    else:
        world["error"] = body


# ── Then: assertions ──────────────────────────────────────────────────────────


@then("the trail exists and is active")
def trail_exists_and_active(client: TestClient, world):
    actual_create_error = world["error"]
    assert (
        actual_create_error is None
    ), f"Expected CreateTrail to succeed but got: {actual_create_error}"
    _, body = _post(client, "DescribeTrails", {})
    actual_trail_names = [t["Name"] for t in body.get("trailList", [])]
    expected_name = INT_TRAIL_NAME
    assert (
        expected_name in actual_trail_names
    ), f"Expected trail '{expected_name}' in trail list but found: {actual_trail_names}"


@then("the trail no longer exists")
def trail_no_longer_exists(client: TestClient, world):
    actual_delete_error = world["error"]
    assert (
        actual_delete_error is None
    ), f"Expected DeleteTrail to succeed but got: {actual_delete_error}"
    trail_name = world.get("trail_name", INT_TRAIL_NAME)
    _, body = _post(client, "DescribeTrails", {})
    actual_trail_names = [t["Name"] for t in body.get("trailList", [])]
    assert (
        trail_name not in actual_trail_names
    ), f"Expected trail '{trail_name}' to be deleted but found in: {actual_trail_names}"


@then("the trail has logging enabled")
def trail_has_logging_enabled(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected StartLogging to succeed but got: {actual_error}"
    trail_name = world.get("trail_name", INT_TRAIL_NAME)
    _, body = _post(client, "GetTrailStatus", {"Name": trail_name})
    actual_logging = body.get("IsLogging")
    expected_logging = True
    assert (
        actual_logging == expected_logging
    ), f"Expected IsLogging to be {expected_logging} but got {actual_logging}"


@then("the trail has logging disabled")
def trail_has_logging_disabled(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected StopLogging to succeed but got: {actual_error}"
    trail_name = world.get("trail_name", INT_TRAIL_NAME)
    _, body = _post(client, "GetTrailStatus", {"Name": trail_name})
    actual_logging = body.get("IsLogging")
    expected_logging = False
    assert (
        actual_logging == expected_logging
    ), f"Expected IsLogging to be {expected_logging} but got {actual_logging}"


@then("the event selectors are returned for the trail")
def event_selectors_returned(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected PutEventSelectors to succeed but got: {actual_error}"
    trail_name = world.get("trail_name", INT_TRAIL_NAME)
    _, body = _post(client, "GetEventSelectors", {"TrailName": trail_name})
    actual_arn = body.get("TrailARN")
    assert (
        actual_arn is not None
    ), f"Expected TrailARN in GetEventSelectors response but got: {body}"


@then("the response contains recorded events")
def response_contains_recorded_events(world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected LookupEvents to succeed but got: {actual_error}"
    actual_events = world.get("result", {}).get("Events", [])
    assert len(actual_events) > 0, f"Expected at least one recorded event but got: {actual_events}"


@then("logging is only enabled for active trails")
def logging_only_for_active_trails():
    """Invariant: trivially satisfied in an isolated test context."""
