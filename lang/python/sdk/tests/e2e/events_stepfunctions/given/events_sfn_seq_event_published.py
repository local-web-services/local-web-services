"""Given: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"'
)
def events_sfn_seq_event_published():
    pytest.skip("Cannot trigger internal EventBridge-to-StepFunctions routing in lws")
