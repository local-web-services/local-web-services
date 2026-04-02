"""Given: the "eventbridge" "bus" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsSqsTestClient


@given('the "eventbridge" "rule" already existed')
def rule_already_exists(lws_session):
    EventsSqsTestClient(lws_session).create_queue()
    EventsSqsTestClient(lws_session).create_rule_targeting_sqs()
