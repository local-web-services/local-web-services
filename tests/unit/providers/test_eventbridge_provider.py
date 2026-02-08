"""Tests for the EventBridge provider."""

from __future__ import annotations

import asyncio
import json
from unittest.mock import AsyncMock

import httpx
import pytest

from ldk.interfaces import ICompute, InvocationResult, LambdaContext
from ldk.providers.eventbridge.provider import (
    EventBridgeProvider,
    EventBusConfig,
    RuleConfig,
    RuleTarget,
    _build_event_envelope,
    _build_scheduled_event,
    _extract_function_name,
)
from ldk.providers.eventbridge.routes import create_eventbridge_app
from ldk.providers.eventbridge.scheduler import (
    get_next_fire_time,
    parse_cron_expression,
    parse_rate_expression,
)

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _make_compute_mock(payload: dict | None = None, error: str | None = None) -> ICompute:
    """Return a mock ICompute whose ``invoke`` resolves to the given result."""
    mock = AsyncMock(spec=ICompute)
    mock.invoke.return_value = InvocationResult(
        payload=payload,
        error=error,
        duration_ms=1.0,
        request_id="test-request-id",
    )
    return mock


def _bus_configs() -> list[EventBusConfig]:
    return [
        EventBusConfig(
            bus_name="custom-bus",
            bus_arn="arn:aws:events:us-east-1:000000000000:event-bus/custom-bus",
        ),
    ]


def _rule_configs() -> list[RuleConfig]:
    return [
        RuleConfig(
            rule_name="my-rule",
            event_bus_name="default",
            event_pattern={
                "source": ["my.app"],
                "detail-type": ["OrderPlaced"],
            },
            targets=[
                RuleTarget(
                    target_id="target-1",
                    arn="arn:aws:lambda:us-east-1:000000000000:function:order-handler",
                ),
            ],
        ),
    ]


async def _started_provider(
    buses: list[EventBusConfig] | None = None,
    rules: list[RuleConfig] | None = None,
) -> EventBridgeProvider:
    provider = EventBridgeProvider(
        buses=_bus_configs() if buses is None else buses,
        rules=_rule_configs() if rules is None else rules,
    )
    await provider.start()
    return provider


def _client(app) -> httpx.AsyncClient:
    transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
    return httpx.AsyncClient(transport=transport, base_url="http://testserver")


# ===========================================================================
# Provider lifecycle tests
# ===========================================================================


class TestEventBridgeProviderLifecycle:
    """Test EventBridgeProvider lifecycle methods."""

    def test_name(self) -> None:
        provider = EventBridgeProvider()
        assert provider.name == "eventbridge"

    @pytest.mark.asyncio
    async def test_health_check_before_start(self) -> None:
        provider = EventBridgeProvider()
        assert await provider.health_check() is False

    @pytest.mark.asyncio
    async def test_start_sets_running(self) -> None:
        provider = await _started_provider()
        assert await provider.health_check() is True

    @pytest.mark.asyncio
    async def test_stop_clears_state(self) -> None:
        provider = await _started_provider()
        await provider.stop()
        assert await provider.health_check() is False

    @pytest.mark.asyncio
    async def test_default_bus_created(self) -> None:
        provider = await _started_provider(buses=[])
        buses = provider.list_buses()
        names = {b.bus_name for b in buses}
        assert "default" in names

    @pytest.mark.asyncio
    async def test_custom_bus_created(self) -> None:
        provider = await _started_provider()
        buses = provider.list_buses()
        names = {b.bus_name for b in buses}
        assert "custom-bus" in names
        assert "default" in names

    @pytest.mark.asyncio
    async def test_rules_loaded_at_start(self) -> None:
        provider = await _started_provider()
        rules = provider.list_rules("default")
        assert len(rules) == 1
        assert rules[0].rule_name == "my-rule"


# ===========================================================================
# PutEvents tests
# ===========================================================================


class TestPutEvents:
    """Test PutEvents functionality."""

    @pytest.mark.asyncio
    async def test_put_events_returns_results(self) -> None:
        provider = await _started_provider()
        results = await provider.put_events(
            [
                {
                    "Source": "my.app",
                    "DetailType": "OrderPlaced",
                    "Detail": json.dumps({"orderId": "123"}),
                },
            ]
        )
        assert len(results) == 1
        assert results[0]["EventId"]
        assert results[0]["ErrorCode"] is None

    @pytest.mark.asyncio
    async def test_put_events_routes_to_matching_rule(self) -> None:
        provider = await _started_provider()
        mock_compute = _make_compute_mock(payload={"statusCode": 200})
        provider.set_compute_providers({"order-handler": mock_compute})

        await provider.put_events(
            [
                {
                    "Source": "my.app",
                    "DetailType": "OrderPlaced",
                    "Detail": json.dumps({"orderId": "abc"}),
                },
            ]
        )

        await asyncio.sleep(0.05)

        mock_compute.invoke.assert_called_once()
        call_args = mock_compute.invoke.call_args
        event = call_args[0][0]
        context = call_args[0][1]

        assert event["source"] == "my.app"
        assert event["detail-type"] == "OrderPlaced"
        assert event["detail"]["orderId"] == "abc"
        assert event["version"] == "0"
        assert event["account"] == "000000000000"
        assert event["region"] == "us-east-1"
        assert isinstance(context, LambdaContext)

    @pytest.mark.asyncio
    async def test_put_events_no_match_no_dispatch(self) -> None:
        provider = await _started_provider()
        mock_compute = _make_compute_mock(payload={"statusCode": 200})
        provider.set_compute_providers({"order-handler": mock_compute})

        await provider.put_events(
            [
                {
                    "Source": "other.app",
                    "DetailType": "SomethingElse",
                    "Detail": "{}",
                },
            ]
        )

        await asyncio.sleep(0.05)
        mock_compute.invoke.assert_not_called()

    @pytest.mark.asyncio
    async def test_put_events_multiple_entries(self) -> None:
        provider = await _started_provider()
        results = await provider.put_events(
            [
                {
                    "Source": "my.app",
                    "DetailType": "OrderPlaced",
                    "Detail": "{}",
                },
                {
                    "Source": "my.app",
                    "DetailType": "OrderShipped",
                    "Detail": "{}",
                },
            ]
        )
        assert len(results) == 2
        assert results[0]["EventId"] != results[1]["EventId"]

    @pytest.mark.asyncio
    async def test_put_events_missing_compute_logs_error(self) -> None:
        """When no compute provider is registered, dispatch should not raise."""
        provider = await _started_provider()
        # No compute providers set

        await provider.put_events(
            [
                {
                    "Source": "my.app",
                    "DetailType": "OrderPlaced",
                    "Detail": "{}",
                },
            ]
        )
        await asyncio.sleep(0.05)
        # Should not raise


# ===========================================================================
# PutRule and PutTargets tests
# ===========================================================================


class TestPutRuleAndTargets:
    """Test PutRule and PutTargets functionality."""

    @pytest.mark.asyncio
    async def test_put_rule_returns_arn(self) -> None:
        provider = await _started_provider(rules=[])
        arn = await provider.put_rule(
            rule_name="new-rule",
            event_pattern={"source": ["test"]},
        )
        assert "new-rule" in arn

    @pytest.mark.asyncio
    async def test_put_rule_adds_to_list(self) -> None:
        provider = await _started_provider(rules=[])
        await provider.put_rule(
            rule_name="new-rule",
            event_pattern={"source": ["test"]},
        )
        rules = provider.list_rules("default")
        assert len(rules) == 1
        assert rules[0].rule_name == "new-rule"

    @pytest.mark.asyncio
    async def test_put_targets_adds_to_rule(self) -> None:
        provider = await _started_provider(rules=[])
        await provider.put_rule(
            rule_name="target-test-rule",
            event_pattern={"source": ["test"]},
        )
        await provider.put_targets(
            rule_name="target-test-rule",
            targets=[
                RuleTarget(
                    target_id="t1",
                    arn="arn:aws:lambda:us-east-1:000000000000:function:my-func",
                )
            ],
        )
        rules = provider.list_rules("default")
        assert len(rules[0].targets) == 1
        assert rules[0].targets[0].target_id == "t1"

    @pytest.mark.asyncio
    async def test_put_targets_nonexistent_rule_raises(self) -> None:
        provider = await _started_provider(rules=[])
        with pytest.raises(KeyError, match="Rule not found"):
            await provider.put_targets(
                rule_name="no-such-rule",
                targets=[
                    RuleTarget(target_id="t1", arn="arn:..."),
                ],
            )


# ===========================================================================
# Cross-service internal publishing
# ===========================================================================


class TestInternalPublish:
    """Test internal event publishing for cross-service routing."""

    @pytest.mark.asyncio
    async def test_publish_internal_returns_event_id(self) -> None:
        provider = await _started_provider(rules=[])
        event_id = await provider.publish_internal(
            source="aws.s3",
            detail_type="Object Created",
            detail={"bucket": "my-bucket", "key": "test.txt"},
        )
        assert event_id  # non-empty string

    @pytest.mark.asyncio
    async def test_publish_internal_routes_to_rule(self) -> None:
        rule = RuleConfig(
            rule_name="s3-rule",
            event_bus_name="default",
            event_pattern={
                "source": ["aws.s3"],
                "detail-type": ["Object Created"],
            },
            targets=[
                RuleTarget(
                    target_id="s3-target",
                    arn="arn:aws:lambda:us-east-1:000000000000:function:s3-handler",
                ),
            ],
        )
        provider = await _started_provider(rules=[rule])
        mock_compute = _make_compute_mock(payload={"ok": True})
        provider.set_compute_providers({"s3-handler": mock_compute})

        await provider.publish_internal(
            source="aws.s3",
            detail_type="Object Created",
            detail={"bucket": "my-bucket", "key": "test.txt"},
        )
        await asyncio.sleep(0.05)

        mock_compute.invoke.assert_called_once()
        event = mock_compute.invoke.call_args[0][0]
        assert event["source"] == "aws.s3"
        assert event["detail"]["bucket"] == "my-bucket"


# ===========================================================================
# Event envelope tests
# ===========================================================================


class TestEventEnvelope:
    """Test event envelope construction."""

    def test_build_event_envelope_structure(self) -> None:
        entry = {
            "Source": "my.app",
            "DetailType": "OrderPlaced",
            "Detail": json.dumps({"orderId": "123"}),
        }
        event = _build_event_envelope(entry, "evt-001")

        assert event["version"] == "0"
        assert event["id"] == "evt-001"
        assert event["source"] == "my.app"
        assert event["account"] == "000000000000"
        assert event["region"] == "us-east-1"
        assert event["detail-type"] == "OrderPlaced"
        assert event["detail"]["orderId"] == "123"
        assert event["resources"] == []
        assert event["time"]

    def test_build_event_envelope_invalid_json_detail(self) -> None:
        entry = {
            "Source": "my.app",
            "DetailType": "Test",
            "Detail": "not-valid-json{",
        }
        event = _build_event_envelope(entry, "evt-002")
        assert event["detail"] == {}

    def test_build_event_envelope_dict_detail(self) -> None:
        entry = {
            "Source": "my.app",
            "DetailType": "Test",
            "Detail": {"already": "dict"},
        }
        event = _build_event_envelope(entry, "evt-003")
        assert event["detail"]["already"] == "dict"

    def test_build_scheduled_event(self) -> None:
        rule = RuleConfig(
            rule_name="sched-rule",
            event_bus_name="default",
            schedule_expression="rate(1 minute)",
        )
        event = _build_scheduled_event(rule)

        assert event["source"] == "aws.events"
        assert event["detail-type"] == "Scheduled Event"
        assert event["detail"] == {}
        assert "sched-rule" in event["resources"][0]

    def test_extract_function_name_from_arn(self) -> None:
        arn = "arn:aws:lambda:us-east-1:000000000000:function:my-func"
        assert _extract_function_name(arn) == "my-func"

    def test_extract_function_name_plain(self) -> None:
        assert _extract_function_name("my-func") == "my-func"


# ===========================================================================
# Scheduler tests
# ===========================================================================


class TestRateExpression:
    """Test rate expression parsing."""

    def test_rate_1_minute(self) -> None:
        assert parse_rate_expression("rate(1 minute)") == 60.0

    def test_rate_5_minutes(self) -> None:
        assert parse_rate_expression("rate(5 minutes)") == 300.0

    def test_rate_1_hour(self) -> None:
        assert parse_rate_expression("rate(1 hour)") == 3600.0

    def test_rate_12_hours(self) -> None:
        assert parse_rate_expression("rate(12 hours)") == 43200.0

    def test_rate_1_day(self) -> None:
        assert parse_rate_expression("rate(1 day)") == 86400.0

    def test_rate_7_days(self) -> None:
        assert parse_rate_expression("rate(7 days)") == 604800.0

    def test_rate_invalid_format(self) -> None:
        with pytest.raises(ValueError):
            parse_rate_expression("rate(invalid)")

    def test_rate_invalid_unit(self) -> None:
        with pytest.raises(ValueError):
            parse_rate_expression("rate(5 weeks)")

    def test_rate_missing_parens(self) -> None:
        with pytest.raises(ValueError):
            parse_rate_expression("rate 5 minutes")


class TestCronExpression:
    """Test cron expression parsing."""

    def test_simple_cron(self) -> None:
        result = parse_cron_expression("cron(0 12 * * ? *)")
        assert result == "0 12 * * *"

    def test_cron_with_day_of_week(self) -> None:
        result = parse_cron_expression("cron(0 8 ? * MON-FRI *)")
        assert result == "0 8 * * MON-FRI"

    def test_cron_specific_day(self) -> None:
        result = parse_cron_expression("cron(15 10 ? * 6L *)")
        assert result == "15 10 * * 6L"

    def test_cron_invalid_fields(self) -> None:
        with pytest.raises(ValueError, match="Expected 6 fields"):
            parse_cron_expression("cron(0 12 * *)")

    def test_cron_missing_parens(self) -> None:
        with pytest.raises(ValueError):
            parse_cron_expression("cron 0 12 * * ? *")


class TestGetNextFireTime:
    """Test next fire time computation."""

    def test_rate_next_fire(self) -> None:
        base = 1000.0
        next_time = get_next_fire_time("rate(5 minutes)", base_time=base)
        assert next_time == 1300.0

    def test_cron_next_fire(self) -> None:
        # Use a known base time: 2024-01-01 00:00:00 UTC
        base = 1704067200.0
        next_time = get_next_fire_time("cron(0 12 * * ? *)", base_time=base)
        # Next fire should be 2024-01-01 12:00:00 UTC
        assert next_time > base

    def test_unsupported_expression(self) -> None:
        with pytest.raises(ValueError, match="Unsupported"):
            get_next_fire_time("fixed(1 hour)")


# ===========================================================================
# Routes tests (wire protocol)
# ===========================================================================


class TestEventBridgeRoutes:
    """Test EventBridge HTTP wire protocol routes."""

    @pytest.mark.asyncio
    async def test_put_events_action(self) -> None:
        provider = await _started_provider()
        app = create_eventbridge_app(provider)

        async with _client(app) as client:
            response = await client.post(
                "/",
                headers={"x-amz-target": "AWSEvents.PutEvents"},
                json={
                    "Entries": [
                        {
                            "Source": "my.app",
                            "DetailType": "OrderPlaced",
                            "Detail": json.dumps({"orderId": "123"}),
                        }
                    ]
                },
            )

        assert response.status_code == 200
        body = response.json()
        assert "Entries" in body
        assert len(body["Entries"]) == 1
        assert body["Entries"][0]["EventId"]
        assert body["FailedEntryCount"] == 0

    @pytest.mark.asyncio
    async def test_put_rule_action(self) -> None:
        provider = await _started_provider(rules=[])
        app = create_eventbridge_app(provider)

        async with _client(app) as client:
            response = await client.post(
                "/",
                headers={"x-amz-target": "AWSEvents.PutRule"},
                json={
                    "Name": "test-rule",
                    "EventPattern": json.dumps({"source": ["test"]}),
                },
            )

        assert response.status_code == 200
        body = response.json()
        assert "RuleArn" in body
        assert "test-rule" in body["RuleArn"]

    @pytest.mark.asyncio
    async def test_put_targets_action(self) -> None:
        provider = await _started_provider()
        app = create_eventbridge_app(provider)

        async with _client(app) as client:
            response = await client.post(
                "/",
                headers={"x-amz-target": "AWSEvents.PutTargets"},
                json={
                    "Rule": "my-rule",
                    "Targets": [
                        {
                            "Id": "new-target",
                            "Arn": "arn:aws:lambda:us-east-1:000000000000:function:new-func",
                        }
                    ],
                },
            )

        assert response.status_code == 200
        body = response.json()
        assert body["FailedEntryCount"] == 0

    @pytest.mark.asyncio
    async def test_put_targets_nonexistent_rule(self) -> None:
        provider = await _started_provider(rules=[])
        app = create_eventbridge_app(provider)

        async with _client(app) as client:
            response = await client.post(
                "/",
                headers={"x-amz-target": "AWSEvents.PutTargets"},
                json={
                    "Rule": "no-such-rule",
                    "Targets": [{"Id": "t1", "Arn": "arn:..."}],
                },
            )

        assert response.status_code == 400

    @pytest.mark.asyncio
    async def test_list_rules_action(self) -> None:
        provider = await _started_provider()
        app = create_eventbridge_app(provider)

        async with _client(app) as client:
            response = await client.post(
                "/",
                headers={"x-amz-target": "AWSEvents.ListRules"},
                json={},
            )

        assert response.status_code == 200
        body = response.json()
        assert "Rules" in body
        assert len(body["Rules"]) == 1
        assert body["Rules"][0]["Name"] == "my-rule"

    @pytest.mark.asyncio
    async def test_list_event_buses_action(self) -> None:
        provider = await _started_provider()
        app = create_eventbridge_app(provider)

        async with _client(app) as client:
            response = await client.post(
                "/",
                headers={"x-amz-target": "AWSEvents.ListEventBuses"},
                json={},
            )

        assert response.status_code == 200
        body = response.json()
        assert "EventBuses" in body
        names = {b["Name"] for b in body["EventBuses"]}
        assert "default" in names
        assert "custom-bus" in names

    @pytest.mark.asyncio
    async def test_unknown_target_returns_400(self) -> None:
        provider = await _started_provider()
        app = create_eventbridge_app(provider)

        async with _client(app) as client:
            response = await client.post(
                "/",
                headers={"x-amz-target": "AWSEvents.Bogus"},
                json={},
            )

        assert response.status_code == 400
        body = response.json()
        assert body["Error"] == "UnknownOperation"

    @pytest.mark.asyncio
    async def test_empty_body_handling(self) -> None:
        provider = await _started_provider()
        app = create_eventbridge_app(provider)

        async with _client(app) as client:
            response = await client.post(
                "/",
                headers={"x-amz-target": "AWSEvents.ListRules"},
                content=b"",
            )

        assert response.status_code == 200
