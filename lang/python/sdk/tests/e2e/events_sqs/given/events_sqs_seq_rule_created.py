"""Given: an EventBridge rule has been created to route matching events to the "SQS" queue"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsSqsTestClient


@given('an EventBridge rule has been created to route matching events to the "SQS" queue')
def events_sqs_seq_rule_created(lws_session):
    EventsSqsTestClient(lws_session).create_queue()
    EventsSqsTestClient(lws_session).create_rule_targeting_sqs()
