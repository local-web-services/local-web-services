"""Given: the rule already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsSnsTestClient


@given("the rule already exists")
def rule_already_exists(lws_session):
    EventsSnsTestClient(lws_session).create_rule_targeting_sns()
