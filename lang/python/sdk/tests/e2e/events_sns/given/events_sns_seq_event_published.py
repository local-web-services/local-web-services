"""Given: an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'an "eventbridge" "event" is published to the "eventbridge" "bus" and routed to the target "sns" "topic"'
)
def events_sns_seq_event_published():
    pytest.skip("Cannot trigger internal EventBridge-to-SNS routing in lws")
