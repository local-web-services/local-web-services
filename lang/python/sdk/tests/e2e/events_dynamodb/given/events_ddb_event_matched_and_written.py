"""
Given: an event has matched an "ENABLED" rule and EventBridge has written an item to the DynamoDB
target
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'an event has matched an "ENABLED" rule and EventBridge has written an item to the DynamoDB target'  # noqa: E501
)
def events_ddb_event_matched_and_written():
    pytest.skip("Cannot trigger internal EventBridge-to-DynamoDB routing in lws")
