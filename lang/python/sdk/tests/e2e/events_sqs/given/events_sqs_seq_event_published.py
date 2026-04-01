"""Given: an event is published to the bus and routed to the target "SQS" queue"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an event is published to the bus and routed to the target "SQS" queue')
def events_sqs_seq_event_published():
    pytest.skip("Cannot trigger internal EventBridge-to-SQS routing in lws")
