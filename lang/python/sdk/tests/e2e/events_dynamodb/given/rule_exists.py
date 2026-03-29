"""Given: the rule exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsDynamodbTestClient


@given("the rule exists")
def rule_exists(lws_session):
    EventsDynamodbTestClient(lws_session).create_bus()
    EventsDynamodbTestClient(lws_session).create_rule()
