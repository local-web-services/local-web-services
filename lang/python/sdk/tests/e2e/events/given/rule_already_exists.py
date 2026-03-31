"""Given: the "eventbridge" "rule" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsTestClient


@given('the "eventbridge" "rule" already existed')
def rule_already_exists(lws_session):
    EventsTestClient(lws_session).create_rule()
