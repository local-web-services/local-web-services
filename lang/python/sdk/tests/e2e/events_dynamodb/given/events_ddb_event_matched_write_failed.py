"""
Given: an event has matched an "ENABLED" rule but the DynamoDB write has failed because the table
is being deleted
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'an event has matched an "ENABLED" rule but the DynamoDB write has failed because the table is being deleted'  # noqa: E501
)
def events_ddb_event_matched_write_failed():
    pytest.skip("Cannot trigger internal EventBridge-to-DynamoDB routing failure in lws")
