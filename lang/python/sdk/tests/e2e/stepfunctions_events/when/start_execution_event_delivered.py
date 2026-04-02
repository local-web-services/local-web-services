"""When: a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when(
    'a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"'
)
def start_execution_event_delivered(lws_session, world):
    pytest.skip("Cannot configure EventBridge event delivery for execution start in lws")
