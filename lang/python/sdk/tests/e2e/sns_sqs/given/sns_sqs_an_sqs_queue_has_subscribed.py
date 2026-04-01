"""Given: a "sqs" "queue" subscribes to a "sns" "topic" """

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsSqsTestClient


@given('a "sqs" "queue" subscribes to a "sns" "topic"')
def sns_sqs_an_sqs_queue_has_subscribed(lws_session):
    SnsSqsTestClient(lws_session).create_topic()
    SnsSqsTestClient(lws_session).create_queue()
    SnsSqsTestClient(lws_session).subscribe_queue_to_topic()
