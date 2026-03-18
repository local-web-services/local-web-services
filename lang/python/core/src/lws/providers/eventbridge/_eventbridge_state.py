"""State dataclasses and event envelope builders for the EventBridge provider."""

from __future__ import annotations

import json
import time
import uuid
from dataclasses import dataclass, field


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
