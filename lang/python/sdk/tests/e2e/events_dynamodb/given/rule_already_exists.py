"""Given: the rule already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsDynamodbTestClient


@given("the rule already existed")
def rule_already_exists(lws_session):
    EventsDynamodbTestClient(lws_session).create_rule()
