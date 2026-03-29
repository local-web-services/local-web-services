"""
Given: the Neptune cluster has stopped and has delivered the state change event to the
EventBridge bus
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    "the Neptune cluster has stopped and has delivered the state change event to the EventBridge bus"  # noqa: E501
)
def neptune_cluster_stopped_event_delivered_seq():
    pytest.skip("Cannot trigger internal Neptune cluster stop event routing in lws")
