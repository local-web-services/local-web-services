"""Given: the "eventbridge" "rule" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsTestClient


@given('the "eventbridge" "rule" existed')
def rule_exists(lws_session):
    EventsTestClient(lws_session).create_rule()
