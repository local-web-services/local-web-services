"""When: an event is published to the bus and triggers an asynchronous Lambda invocation"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("an event is published to the bus and triggers an asynchronous Lambda invocation")
def put_event_triggers_invocation(world):
    pytest.skip("Cannot trigger internal EventBridge->Lambda routing in lws")
