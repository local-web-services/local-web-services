"""
Given: a user action has occurred in the pool and Cognito has delivered the event to the
EventBridge bus
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    "a user action has occurred in the pool and Cognito has delivered the event to the EventBridge bus"  # noqa: E501
)
def cognito_events_user_action_delivered():
    pytest.skip("Cannot trigger internal Cognito user action event routing in lws")
