"""Then: the "step functions" "state machine" will send execution state change "eventbridge" "events" to the "eventbridge" "bus" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'the "step functions" "state machine" will send execution state change "eventbridge" "events" to the "eventbridge" "bus"'
)
def sm_will_send_events(world):
    pytest.skip("Cannot observe EventBridge publishing configuration in lws")
