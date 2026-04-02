"""Given: an "ENABLED" "eventbridge" "rule" existed on the "eventbridge" "bus" targeting a "sns" "topic" """

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsSnsTestClient


@given(
    'an "ENABLED" "eventbridge" "rule" existed on the "eventbridge" "bus" targeting a "sns" "topic"'
)
def enabled_rule_exists_targeting_topic(lws_session):
    EventsSnsTestClient(lws_session).create_rule_targeting_sns()
