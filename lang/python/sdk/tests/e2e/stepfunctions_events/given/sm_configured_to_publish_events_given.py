"""Given: the state machine is configured to publish execution events to the event bus"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the state machine is configured to publish execution events to the event bus")
def sm_configured_to_publish_events_given():
    pytest.skip("Cannot pre-set EventBridge publishing configuration on state machine")
