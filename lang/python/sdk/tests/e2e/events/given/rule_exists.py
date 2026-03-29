"""Given: the rule exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsTestClient


@given("the rule exists")
def rule_exists(lws_session):
    EventsTestClient(lws_session).create_rule()
