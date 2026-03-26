"""Given: rule_name in rule_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsTestClient


@given("rule_name in rule_status")
def rule_name_in_rule_status(lws_session):
    EventsTestClient(lws_session).create_rule()
