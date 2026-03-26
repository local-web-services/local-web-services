"""
Given: a cluster modification has begun and DocumentDB has delivered the event to the EventBridge
bus
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    "a cluster modification has begun and DocumentDB has delivered the event to the EventBridge bus"
)
def docdb_events_cluster_modification_delivered():
    pytest.skip("Cannot trigger internal DocumentDB cluster modification event routing in lws")
