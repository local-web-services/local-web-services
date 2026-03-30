"""Given: an "ENABLED" rule exists on the bus targeting a queue"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsSqsTestClient


@given('an "ENABLED" rule exists on the bus targeting a queue')
def enabled_rule_exists_targeting_queue(lws_session):
    EventsSqsTestClient(lws_session).create_queue()
    EventsSqsTestClient(lws_session).create_rule_targeting_sqs()
