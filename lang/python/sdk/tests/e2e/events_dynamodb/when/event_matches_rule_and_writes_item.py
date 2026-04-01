"""When: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target')
def event_matches_rule_and_writes_item(world):
    pytest.skip("Cannot trigger internal EventBridge-to-DynamoDB routing in lws")
