"""Given: the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'the "step functions" "state machine" is configured to publish execution events to the "eventbridge" "bus"'
)
def sm_configured_to_publish_events_given():
    pytest.skip("Cannot pre-set EventBridge publishing configuration on state machine")
