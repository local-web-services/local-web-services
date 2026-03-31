"""When: a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when(
    'a "cognito" "user" action occurs in the "cognito" "user pool" and Cognito delivers the event to the EventBridge bus'
)
def user_action_event_delivered(lws_session, world):
    pytest.skip("Cannot trigger internal Cognito user action event routing in lws")
