"""Given: an event has been published to the bus and has triggered a new Step Functions execution"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an event has been published to the bus and has triggered a new Step Functions execution")
def events_sfn_seq_event_published():
    pytest.skip("Cannot trigger internal EventBridge-to-StepFunctions routing in lws")
