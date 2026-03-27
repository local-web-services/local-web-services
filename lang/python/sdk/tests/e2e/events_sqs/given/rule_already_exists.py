"""Given: the rule already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsSqsTestClient


@given("the rule already exists")
def rule_already_exists(lws_session):
    EventsSqsTestClient(lws_session).create_queue()
    EventsSqsTestClient(lws_session).create_rule_targeting_sqs()
