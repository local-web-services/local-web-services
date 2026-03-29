"""Given: an EventBridge rule has been created to route matching events to an "SNS" topic"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsSnsTestClient


@given('an EventBridge rule has been created to route matching events to an "SNS" topic')
def events_sns_seq_rule_created(lws_session):
    EventsSnsTestClient(lws_session).create_rule_targeting_sns()
