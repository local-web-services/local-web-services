"""Given: an event is published to the bus and routed to the target "SNS" topic"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an event is published to the bus and routed to the target "SNS" topic')
def events_sns_seq_event_published():
    pytest.skip("Cannot trigger internal EventBridge-to-SNS routing in lws")
