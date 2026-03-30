"""When: the state machine is configured to publish execution events to the event bus"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the state machine is configured to publish execution events to the event bus")
def configure_event_publishing(world):
    pytest.skip("Cannot configure EventBridge publishing on state machine in lws")
