"""Given: an "ENABLED" "eventbridge" "rule" existed on the "eventbridge" "bus" targeting a "sqs" "queue" """

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsSqsTestClient


@given(
    'an "ENABLED" "eventbridge" "rule" existed on the "eventbridge" "bus" targeting a "sqs" "queue"'
)
def enabled_rule_exists_targeting_queue(lws_session):
    EventsSqsTestClient(lws_session).create_queue()
    EventsSqsTestClient(lws_session).create_rule_targeting_sqs()
