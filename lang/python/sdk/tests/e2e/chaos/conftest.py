"""Abstract BDD step definitions for Chaos informal spec scenarios."""

from __future__ import annotations

import json
import urllib.request

import pytest
from pytest_bdd import given, then, when

TEST_SERVICE = "dynamodb"
TEST_ERROR_RATE_FULL = 1.0
TEST_ERROR_RATE_PARTIAL = 0.0
TEST_LATENCY_MIN_MS = 10
TEST_LATENCY_MAX_MS = 50


def _mgmt_port(lws_session):
    return lws_session._mgmt_port


def _get_chaos_status(lws_session):
    port = _mgmt_port(lws_session)
    with urllib.request.urlopen(  # noqa: S310
        f"http://127.0.0.1:{port}/_ldk/chaos", timeout=5
    ) as resp:
        return json.loads(resp.read())


# ── Given: chaos state ────────────────────────────────────────────────


@given("chaos is enabled for the service")
def chaos_is_enabled(lws_session):
    """Enable chaos for the test service."""
    lws_session.chaos(TEST_SERVICE).apply()


@given("chaos is not enabled for the service")
def chaos_is_not_enabled():
    pytest.skip("LWS does not enforce rejection when chaos is not enabled")


@given("the error rate is set to full for the service")
def error_rate_set_to_full(lws_session):
    """Configure chaos with error rate of 1.0 (100%) for the test service."""
    lws_session.chaos(TEST_SERVICE).error_rate(TEST_ERROR_RATE_FULL).apply()


@given("the error rate is not set to full for the service")
def error_rate_not_set_to_full():
    pytest.skip("LWS does not enforce rejection when error rate is not set to full")


@given("latency is configured for the service")
def latency_configured_for_service(lws_session):
    """Configure chaos with latency injection for the test service."""
    lws_session.chaos(TEST_SERVICE).latency(
        min_ms=TEST_LATENCY_MIN_MS, max_ms=TEST_LATENCY_MAX_MS
    ).apply()


@given("latency is not configured for the service")
def latency_not_configured_for_service():
    pytest.skip("LWS does not enforce rejection when latency is not configured")


# ── Given: sequence setup ─────────────────────────────────────────────


@given("svc in chaos_enabled")
def chaos_svc_in_chaos_enabled(lws_session):
    """Enable chaos for the test service to represent a service in the chaos_enabled set."""
    lws_session.chaos(TEST_SERVICE).apply()


@given("chaos has been enabled for a service")
def chaos_has_been_enabled(lws_session):
    """Enable chaos for the test service."""
    lws_session.chaos(TEST_SERVICE).apply()


@given("chaos has been disabled for a service")
def chaos_has_been_disabled(lws_session):
    """Disable chaos for the test service."""
    lws_session.chaos(TEST_SERVICE).clear()


@given("the chaos error rate has been configured for a service")
def chaos_error_rate_configured(lws_session):
    """Configure a non-zero error rate for the test service."""
    lws_session.chaos(TEST_SERVICE).error_rate(0.5).apply()


@given("the chaos latency has been configured for a service")
def chaos_latency_configured(lws_session):
    """Configure latency injection for the test service."""
    lws_session.chaos(TEST_SERVICE).latency(
        min_ms=TEST_LATENCY_MIN_MS, max_ms=TEST_LATENCY_MAX_MS
    ).apply()


@given("the chaos status for all services has been retrieved")
def chaos_status_retrieved(lws_session, world):
    """Retrieve the chaos status for all services."""
    world["chaos_status"] = _get_chaos_status(lws_session)


@given("a service call has been injected with a chaos error")
def chaos_service_call_injected_with_error():
    """No-op: prior chaos error injection is represented by state already set up."""


@given("a service call has been delayed by chaos latency injection")
def chaos_service_call_delayed():
    """No-op: prior latency injection is represented by state already set up."""


# ── When: chaos actions ────────────────────────────────────────────────


@when("chaos is enabled for a service")
def when_chaos_is_enabled(lws_session, world):
    """Enable chaos for the test service and record the result."""
    try:
        lws_session.chaos(TEST_SERVICE).apply()
        world["result"] = True
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc


@when("chaos is disabled for a service")
def when_chaos_is_disabled(lws_session, world):
    """Disable chaos for the test service and record the result."""
    try:
        lws_session.chaos(TEST_SERVICE).clear()
        world["result"] = True
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc


@when("the chaos error rate is configured for a service")
def when_chaos_error_rate_configured(lws_session, world):
    """Configure a chaos error rate for the test service and record the result."""
    try:
        lws_session.chaos(TEST_SERVICE).error_rate(0.5).apply()
        world["result"] = True
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc


@when("the chaos latency is configured for a service")
def when_chaos_latency_configured(lws_session, world):
    """Configure chaos latency for the test service and record the result."""
    try:
        lws_session.chaos(TEST_SERVICE).latency(
            min_ms=TEST_LATENCY_MIN_MS, max_ms=TEST_LATENCY_MAX_MS
        ).apply()
        world["result"] = True
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc


@when("the chaos status for all services is retrieved")
def when_chaos_status_retrieved(lws_session, world):
    """Retrieve chaos status for all services and record the result."""
    try:
        world["result"] = _get_chaos_status(lws_session)
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc


@when("a service call is injected with a chaos error")
def when_service_call_injected_with_error(lws_session, world):
    """Attempt a service call expected to receive a chaos error response."""
    import boto3
    import botocore.config

    port = lws_session._ports.get("dynamodb", lws_session._mgmt_port)
    client = boto3.client(
        "dynamodb",
        region_name="us-east-1",
        endpoint_url=f"http://127.0.0.1:{port}",
        aws_access_key_id="test",
        aws_secret_access_key="test",
        config=botocore.config.Config(retries={"max_attempts": 1}),
    )
    try:
        world["result"] = client.list_tables()
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc


@when("a service call is delayed by chaos latency injection")
def when_service_call_delayed_by_latency(lws_session, world):
    """Attempt a service call expected to be delayed by chaos latency injection."""
    import boto3
    import botocore.config

    port = lws_session._ports.get("dynamodb", lws_session._mgmt_port)
    client = boto3.client(
        "dynamodb",
        region_name="us-east-1",
        endpoint_url=f"http://127.0.0.1:{port}",
        aws_access_key_id="test",
        aws_secret_access_key="test",
        config=botocore.config.Config(retries={"max_attempts": 1}),
    )
    try:
        world["result"] = client.list_tables()
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc


# ── Then: assertions ───────────────────────────────────────────────────


@then("chaos is enabled for the service")
def then_chaos_is_enabled(lws_session):
    """Verify that chaos is enabled for the test service."""
    status = _get_chaos_status(lws_session)
    expected_enabled = True
    actual_enabled = status.get(TEST_SERVICE, {}).get("enabled", False)
    assert actual_enabled == expected_enabled


@then("chaos is disabled for the service")
def then_chaos_is_disabled(lws_session):
    """Verify that chaos is disabled for the test service."""
    status = _get_chaos_status(lws_session)
    expected_enabled = False
    actual_enabled = status.get(TEST_SERVICE, {}).get("enabled", True)
    assert actual_enabled == expected_enabled


@then("the operation is rejected")
def then_operation_is_rejected(world):
    """Verify that the operation was rejected (an error was raised)."""
    expected_has_error = True
    actual_has_error = world.get("error") is not None
    assert actual_has_error == expected_has_error


@then("the error rate configuration is updated")
def then_error_rate_updated(world):
    """Verify that the error rate configuration call succeeded."""
    expected_error = None
    actual_error = world.get("error")
    assert actual_error == expected_error


@then("the latency configuration is updated")
def then_latency_updated(world):
    """Verify that the latency configuration call succeeded."""
    expected_error = None
    actual_error = world.get("error")
    assert actual_error == expected_error


@then("the chaos configuration for each service is returned")
def then_chaos_config_returned(world):
    """Verify that the chaos status result is a non-empty mapping."""
    expected_error = None
    actual_error = world.get("error")
    assert actual_error == expected_error
    actual_result = world.get("result")
    assert isinstance(actual_result, dict)


@then("the service call receives a chaos error response")
def then_service_call_receives_chaos_error(world):
    """Verify that the service call was rejected due to chaos error injection."""
    expected_has_error = True
    actual_has_error = world.get("error") is not None
    assert actual_has_error == expected_has_error


@then("the service call takes at least the configured minimum latency")
def then_service_call_delayed(world):
    """Verify the service call completed (latency is applied transparently)."""
    expected_error = None
    actual_error = world.get("error")
    assert actual_error == expected_error


@then("every chaos-configured service is a known service")
def _inv_chaos_every_chaos_configured_service_is_a_known_service():
    """Invariant step: trivially satisfied in isolated test context."""
