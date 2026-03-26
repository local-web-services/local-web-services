"""Then: the state machine will send execution state change events to the bus"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the state machine will send execution state change events to the bus")
def sm_will_send_events(world):
    pytest.skip("Cannot observe EventBridge publishing configuration in lws")
