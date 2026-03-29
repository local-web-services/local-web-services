"""
When: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being
deleted
"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when(
    'an event matches an "ENABLED" rule but the DynamoDB write fails'
    " because the table is being deleted"
)
def event_matches_rule_but_table_deleting(world):
    pytest.skip("Cannot trigger internal event routing to a deleting table in lws")
