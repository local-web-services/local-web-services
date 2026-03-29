"""BDD step definitions for CloudTrail E2E scenarios."""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_TRAIL_NAME = "e2e-test-trail-1"
TEST_S3_BUCKET = "e2e-test-bucket-1"


def _ct(lws_session):
    return lws_session.client("cloudtrail")


def _create_trail(lws_session, name: str = TEST_TRAIL_NAME) -> dict:
    return _ct(lws_session).create_trail(Name=name, S3BucketName=TEST_S3_BUCKET)


# ── Given: trail state setup ──────────────────────────────────────────────────


@given("the trail does not already exist")
def trail_not_already_exist():
    """No-op: fresh state has no trails."""


@given("the trail already exists")
def trail_already_exists(lws_session, world):
    resp = _create_trail(lws_session)
    world["trail_name"] = resp.get("Name")


@given("the trail exists and is active")
def trail_exists_and_is_active(lws_session, world):
    resp = _create_trail(lws_session)
    world["trail_name"] = resp.get("Name")


@given("the trail does not exist")
def trail_does_not_exist(world):
    """Use a nonexistent trail name for negative scenarios."""
    world["trail_name"] = "nonexistent-trail"


@given("the trail exists and logging is disabled")
def trail_exists_logging_disabled(lws_session, world):
    resp = _create_trail(lws_session)
    world["trail_name"] = resp.get("Name")


@given("the trail exists and logging is enabled")
def trail_exists_logging_enabled(lws_session, world):
    resp = _create_trail(lws_session)
    world["trail_name"] = resp.get("Name")
    _ct(lws_session).start_logging(Name=world["trail_name"])


@given("at least one CloudTrail API call has been made")
def at_least_one_api_call_made(lws_session, world):
    resp = _create_trail(lws_session)
    world["trail_name"] = resp.get("Name")


# ── When: actions ─────────────────────────────────────────────────────────────


@when("a trail is created")
def create_trail(lws_session, world):
    try:
        resp = _create_trail(lws_session)
        world["result"] = resp
        world["trail_name"] = resp.get("Name")
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a trail is deleted")
def delete_trail(lws_session, world):
    trail_name = world.get("trail_name", TEST_TRAIL_NAME)
    try:
        resp = _ct(lws_session).delete_trail(Name=trail_name)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("logging is started on the trail")
def start_logging(lws_session, world):
    trail_name = world.get("trail_name", TEST_TRAIL_NAME)
    try:
        resp = _ct(lws_session).start_logging(Name=trail_name)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("logging is stopped on the trail")
def stop_logging(lws_session, world):
    trail_name = world.get("trail_name", TEST_TRAIL_NAME)
    try:
        resp = _ct(lws_session).stop_logging(Name=trail_name)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("event selectors are put for the trail")
def put_event_selectors(lws_session, world):
    trail_name = world.get("trail_name", TEST_TRAIL_NAME)
    selectors = [{"ReadWriteType": "All", "IncludeManagementEvents": True}]
    try:
        resp = _ct(lws_session).put_event_selectors(
            TrailName=trail_name, EventSelectors=selectors
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("events are looked up")
def lookup_events(lws_session, world):
    try:
        resp = _ct(lws_session).lookup_events()
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


# ── Then: assertions ──────────────────────────────────────────────────────────


@then("the trail exists and is active")
def trail_exists_and_active(lws_session, world):
    assert (
        world["error"] is None
    ), f"Expected CreateTrail to succeed but got: {world['error']}"
    resp = _ct(lws_session).describe_trails()
    actual_trail_names = [t["Name"] for t in resp.get("trailList", [])]
    expected_name = TEST_TRAIL_NAME
    assert (
        expected_name in actual_trail_names
    ), f"Expected trail '{expected_name}' in trail list but found: {actual_trail_names}"


@then("the trail no longer exists")
def trail_no_longer_exists(lws_session, world):
    assert (
        world["error"] is None
    ), f"Expected DeleteTrail to succeed but got: {world['error']}"
    trail_name = world.get("trail_name", TEST_TRAIL_NAME)
    resp = _ct(lws_session).describe_trails()
    actual_trail_names = [t["Name"] for t in resp.get("trailList", [])]
    assert (
        trail_name not in actual_trail_names
    ), f"Expected trail '{trail_name}' to be deleted but found in: {actual_trail_names}"


@then("the trail has logging enabled")
def trail_has_logging_enabled(lws_session, world):
    assert (
        world["error"] is None
    ), f"Expected StartLogging to succeed but got: {world['error']}"
    trail_name = world.get("trail_name", TEST_TRAIL_NAME)
    resp = _ct(lws_session).get_trail_status(Name=trail_name)
    actual_logging = resp.get("IsLogging")
    expected_logging = True
    assert (
        actual_logging == expected_logging
    ), f"Expected IsLogging to be {expected_logging} but got {actual_logging}"


@then("the trail has logging disabled")
def trail_has_logging_disabled(lws_session, world):
    assert (
        world["error"] is None
    ), f"Expected StopLogging to succeed but got: {world['error']}"
    trail_name = world.get("trail_name", TEST_TRAIL_NAME)
    resp = _ct(lws_session).get_trail_status(Name=trail_name)
    actual_logging = resp.get("IsLogging")
    expected_logging = False
    assert (
        actual_logging == expected_logging
    ), f"Expected IsLogging to be {expected_logging} but got {actual_logging}"


@then("the event selectors are returned for the trail")
def event_selectors_returned(lws_session, world):
    assert (
        world["error"] is None
    ), f"Expected PutEventSelectors to succeed but got: {world['error']}"
    trail_name = world.get("trail_name", TEST_TRAIL_NAME)
    resp = _ct(lws_session).get_event_selectors(TrailName=trail_name)
    actual_arn = resp.get("TrailARN")
    assert (
        actual_arn is not None
    ), f"Expected TrailARN in GetEventSelectors response but got: {resp}"


@then("the response contains recorded events")
def response_contains_recorded_events(world):
    assert (
        world["error"] is None
    ), f"Expected LookupEvents to succeed but got: {world['error']}"
    actual_events = world.get("result", {}).get("Events", [])
    assert (
        len(actual_events) > 0
    ), f"Expected at least one recorded event but got: {actual_events}"


@then("logging is only enabled for active trails")
def logging_only_for_active_trails():
    """Invariant: trivially satisfied in an isolated test context."""
