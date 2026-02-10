"""EventBridge provider for local development.

Implements the ``IEventBus`` interface and ``Provider`` lifecycle.
Manages event buses, rules, pattern-based routing, and scheduled rules.
Lambda targets are invoked via registered compute providers.
"""

from __future__ import annotations

import asyncio
import json
import logging
import time
import uuid
from dataclasses import dataclass, field

from lws.interfaces.compute import ICompute, LambdaContext
from lws.interfaces.event_bus import IEventBus
from lws.interfaces.provider import ProviderStatus
from lws.providers.eventbridge.pattern_matcher import match_event
from lws.providers.eventbridge.scheduler import ScheduledRule, ScheduleRunner

logger = logging.getLogger(__name__)


@dataclass
class RuleConfig:
    """Configuration for an EventBridge rule."""

    rule_name: str
    event_bus_name: str
    event_pattern: dict | None = None
    schedule_expression: str | None = None
    targets: list[RuleTarget] = field(default_factory=list)
    enabled: bool = True


@dataclass
class RuleTarget:
    """A target for an EventBridge rule."""

    target_id: str
    arn: str
    input_path: str | None = None
    input_template: str | None = None


@dataclass
class EventBusConfig:
    """Configuration for an EventBridge event bus."""

    bus_name: str
    bus_arn: str


class EventBridgeProvider(IEventBus):
    """In-memory EventBridge provider that manages event buses and rules.

    Parameters
    ----------
    buses:
        List of event bus configurations to create at startup.
    rules:
        List of rule configurations to register at startup.
    """

    def __init__(
        self,
        buses: list[EventBusConfig] | None = None,
        rules: list[RuleConfig] | None = None,
    ) -> None:
        self._bus_configs = buses or []
        self._rule_configs = rules or []
        self._buses: dict[str, EventBusConfig] = {}
        self._rules: dict[str, RuleConfig] = {}
        self._status = ProviderStatus.STOPPED
        self._compute_providers: dict[str, ICompute] = {}
        self._lock = asyncio.Lock()
        self._scheduler = ScheduleRunner()

    # -- Provider lifecycle ---------------------------------------------------

    @property
    def name(self) -> str:
        return "eventbridge"

    async def start(self) -> None:
        """Create event buses and rules, then start scheduled rules."""
        async with self._lock:
            self._ensure_default_bus()
            for bus_config in self._bus_configs:
                self._buses[bus_config.bus_name] = bus_config
            for rule_config in self._rule_configs:
                self._rules[rule_config.rule_name] = rule_config
            self._status = ProviderStatus.RUNNING

        scheduled = self._build_scheduled_rules()
        if scheduled:
            await self._scheduler.start(scheduled)

    async def stop(self) -> None:
        """Stop all scheduled tasks and clear state."""
        await self._scheduler.stop()
        async with self._lock:
            self._buses.clear()
            self._rules.clear()
            self._status = ProviderStatus.STOPPED

    async def health_check(self) -> bool:
        return self._status is ProviderStatus.RUNNING

    # -- Cross-provider wiring ------------------------------------------------

    def set_compute_providers(self, providers: dict[str, ICompute]) -> None:
        """Register compute providers for Lambda target dispatch."""
        self._compute_providers = providers

    # -- IEventBus interface --------------------------------------------------

    async def put_events(self, entries: list[dict]) -> list[dict]:
        """Publish one or more events to the event bus.

        Each entry should contain: Source, DetailType, Detail, and
        optionally EventBusName.  Returns a list of result entries.
        """
        results: list[dict] = []
        for entry in entries:
            event_id = str(uuid.uuid4())
            event = _build_event_envelope(entry, event_id)
            bus_name = entry.get("EventBusName", "default")
            matched = await self._route_event(event, bus_name)
            results.append({"EventId": event_id, "ErrorCode": None, "ErrorMessage": None})
            logger.debug(
                "Event %s routed to %d rule(s) on bus '%s'",
                event_id,
                matched,
                bus_name,
            )
        return results

    # -- Public API -----------------------------------------------------------

    async def put_rule(
        self,
        rule_name: str,
        event_bus_name: str = "default",
        event_pattern: dict | None = None,
        schedule_expression: str | None = None,
        targets: list[RuleTarget] | None = None,
    ) -> str:
        """Create or update a rule. Returns the rule ARN."""
        rule = RuleConfig(
            rule_name=rule_name,
            event_bus_name=event_bus_name,
            event_pattern=event_pattern,
            schedule_expression=schedule_expression,
            targets=targets or [],
        )
        async with self._lock:
            self._rules[rule_name] = rule
        arn = f"arn:aws:events:us-east-1:000000000000:rule/{rule_name}"
        return arn

    async def put_targets(self, rule_name: str, targets: list[RuleTarget]) -> None:
        """Add targets to an existing rule."""
        async with self._lock:
            rule = self._rules.get(rule_name)
            if rule is None:
                raise KeyError(f"Rule not found: {rule_name}")
            rule.targets.extend(targets)

    def list_rules(self, event_bus_name: str = "default") -> list[RuleConfig]:
        """Return all rules for a given event bus."""
        return [r for r in self._rules.values() if r.event_bus_name == event_bus_name]

    def list_buses(self) -> list[EventBusConfig]:
        """Return all event buses."""
        return list(self._buses.values())

    async def create_event_bus(self, bus_name: str) -> str:
        """Create an event bus. Returns the bus ARN. Idempotent."""
        arn = f"arn:aws:events:us-east-1:000000000000:event-bus/{bus_name}"
        async with self._lock:
            if bus_name not in self._buses:
                self._buses[bus_name] = EventBusConfig(bus_name=bus_name, bus_arn=arn)
        return arn

    async def delete_event_bus(self, bus_name: str) -> None:
        """Delete an event bus. Raises KeyError if not found."""
        if bus_name == "default":
            raise ValueError("Cannot delete the default event bus")
        async with self._lock:
            if bus_name not in self._buses:
                raise KeyError(f"Event bus not found: {bus_name}")
            del self._buses[bus_name]

    def describe_event_bus(self, bus_name: str) -> dict:
        """Describe an event bus. Raises KeyError if not found."""
        bus = self._buses.get(bus_name)
        if bus is None:
            raise KeyError(f"Event bus not found: {bus_name}")
        return {
            "Name": bus.bus_name,
            "Arn": bus.bus_arn,
        }

    async def delete_rule(self, rule_name: str) -> None:
        """Delete a rule. Raises KeyError if not found."""
        async with self._lock:
            if rule_name not in self._rules:
                raise KeyError(f"Rule not found: {rule_name}")
            del self._rules[rule_name]

    # -- Internal event publishing for cross-service routing ------------------

    async def publish_internal(
        self,
        source: str,
        detail_type: str,
        detail: dict,
        event_bus_name: str = "default",
    ) -> str:
        """Publish an event from another provider (e.g. aws.s3, aws.dynamodb).

        Returns the event ID.
        """
        entry = {
            "Source": source,
            "DetailType": detail_type,
            "Detail": json.dumps(detail),
            "EventBusName": event_bus_name,
        }
        results = await self.put_events([entry])
        return results[0]["EventId"]

    # -- Routing --------------------------------------------------------------

    async def _route_event(self, event: dict, bus_name: str) -> int:
        """Route an event to all matching rules on the given bus.

        Returns the number of rules that matched.
        """
        matched = 0
        rules = self.list_rules(bus_name)
        for rule in rules:
            if not rule.enabled or not rule.event_pattern:
                continue
            if match_event(rule.event_pattern, event):
                matched += 1
                for target in rule.targets:
                    asyncio.create_task(self._dispatch_target(target, event))
        return matched

    async def _dispatch_target(self, target: RuleTarget, event: dict) -> None:
        """Dispatch an event to a single rule target."""
        try:
            function_name = _extract_function_name(target.arn)
            compute = self._compute_providers.get(function_name)
            if compute is None:
                logger.error(
                    "No compute provider for target: %s",
                    target.arn,
                )
                return
            context = LambdaContext(
                function_name=function_name,
                memory_limit_in_mb=128,
                timeout_seconds=30,
                aws_request_id=str(uuid.uuid4()),
                invoked_function_arn=target.arn,
            )
            await compute.invoke(event, context)
        except Exception:
            logger.exception(
                "Failed to dispatch event to target %s",
                target.arn,
            )

    # -- Scheduling -----------------------------------------------------------

    def _build_scheduled_rules(self) -> list[ScheduledRule]:
        """Build ScheduledRule objects for all rules with schedule expressions."""
        scheduled: list[ScheduledRule] = []
        for rule in self._rules.values():
            if not rule.schedule_expression or not rule.enabled:
                continue
            scheduled.append(
                ScheduledRule(
                    rule_name=rule.rule_name,
                    schedule_expression=rule.schedule_expression,
                    callback=self._make_schedule_callback(rule),
                )
            )
        return scheduled

    def _make_schedule_callback(self, rule: RuleConfig):  # noqa: ANN202
        """Create a callback coroutine for a scheduled rule."""

        async def _callback() -> None:
            event = _build_scheduled_event(rule)
            for target in rule.targets:
                await self._dispatch_target(target, event)

        return _callback

    # -- Helpers --------------------------------------------------------------

    def _ensure_default_bus(self) -> None:
        """Ensure a default event bus exists."""
        if "default" not in self._buses:
            self._buses["default"] = EventBusConfig(
                bus_name="default",
                bus_arn="arn:aws:events:us-east-1:000000000000:event-bus/default",
            )


# ---------------------------------------------------------------------------
# Event envelope builders
# ---------------------------------------------------------------------------


def _build_event_envelope(entry: dict, event_id: str) -> dict:
    """Build a full EventBridge event envelope from a PutEvents entry."""
    detail_str = entry.get("Detail", "{}")
    if isinstance(detail_str, str):
        try:
            detail = json.loads(detail_str)
        except json.JSONDecodeError:
            detail = {}
    else:
        detail = detail_str

    return {
        "version": "0",
        "id": event_id,
        "source": entry.get("Source", ""),
        "account": "000000000000",
        "time": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        "region": "us-east-1",
        "resources": [],
        "detail-type": entry.get("DetailType", ""),
        "detail": detail,
    }


def _build_scheduled_event(rule: RuleConfig) -> dict:
    """Build the event envelope for a scheduled rule invocation."""
    return {
        "version": "0",
        "id": str(uuid.uuid4()),
        "source": "aws.events",
        "account": "000000000000",
        "time": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        "region": "us-east-1",
        "resources": [f"arn:aws:events:us-east-1:000000000000:rule/{rule.rule_name}"],
        "detail-type": "Scheduled Event",
        "detail": {},
    }


def _extract_function_name(arn: str) -> str:
    """Extract the function name from a Lambda ARN.

    Handles both full ARNs and plain function names.
    """
    if ":" in arn:
        return arn.rsplit(":", 1)[-1]
    return arn
