"""When: an "eventbridge" "event" matches an "ENABLED" "eventbridge" "rule" and writes an "item" to the "dynamodb" target"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when(
    'an "eventbridge" "event" matches an "ENABLED" "eventbridge" "rule" and writes an "item" to the "dynamodb" target'
)
def event_matches_rule_and_writes_item(world):
    pytest.skip("Cannot trigger internal EventBridge-to-DynamoDB routing in lws")
