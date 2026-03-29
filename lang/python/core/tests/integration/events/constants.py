"""Constants and shared helpers for EventBridge integration tests."""

from __future__ import annotations

import json

INT_BUS = "int-test-bus-1"

INT_RULE = "int-test-rule-1"

INT_TARGET_ID = "int-test-target-1"

INT_TARGET_ARN = "arn:aws:sqs:us-east-1:000000000000:int-test-q1"

EVENT_PATTERN = json.dumps({"source": ["int.test.source"]})

_EVENTS_TARGET = "AWSEvents"


def _store(world: dict, r) -> None:
    if r.status_code == 200:
        world["result"] = r.json()
        world["error"] = None
    else:
        try:
            body = r.json()
        except Exception:
            body = {"Message": r.text or "Internal Server Error"}
        world["result"] = None
        world["error"] = body
