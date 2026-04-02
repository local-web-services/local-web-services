"""Given: a "eventbridge" "rule" was "ENABLED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsDynamodbTestClient


@given('a "eventbridge" "rule" was "ENABLED"')
def a_rule_is_enabled(lws_session):
    EventsDynamodbTestClient(lws_session).create_bus()
    EventsDynamodbTestClient(lws_session).create_rule()
