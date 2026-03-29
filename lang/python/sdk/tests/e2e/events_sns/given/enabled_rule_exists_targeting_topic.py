"""Given: an "ENABLED" rule exists on the bus targeting a topic"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsSnsTestClient


@given('an "ENABLED" rule exists on the bus targeting a topic')
def enabled_rule_exists_targeting_topic(lws_session):
    EventsSnsTestClient(lws_session).create_rule_targeting_sns()
