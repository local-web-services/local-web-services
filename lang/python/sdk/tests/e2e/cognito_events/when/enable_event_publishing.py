"""When: EventBridge publishing is enabled on the user pool"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("EventBridge publishing is enabled on the user pool")
def enable_event_publishing(lws_session, world):
    pytest.skip("Cannot trigger internal EventBridge publishing configuration in lws")
