"""Given: an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sqs" "queue" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sqs" "queue"'
)
def events_sqs_seq_event_published():
    pytest.skip("Cannot trigger internal EventBridge-to-SQS routing in lws")
