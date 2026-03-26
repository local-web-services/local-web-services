"""
Given: the "RDS" instance has stopped and has delivered the state change event to the EventBridge
bus
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'the "RDS" instance has stopped and has delivered the state change event to the EventBridge bus'
)
def rds_instance_stopped_event_delivered():
    pytest.skip("Cannot trigger internal RDS DB instance stop event routing in lws")
