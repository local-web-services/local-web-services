"""When: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when(
    'an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers an asynchronous "lambda" "function" invocation'
)
def put_event_triggers_invocation(world):
    pytest.skip("Cannot trigger internal EventBridge->Lambda routing in lws")
