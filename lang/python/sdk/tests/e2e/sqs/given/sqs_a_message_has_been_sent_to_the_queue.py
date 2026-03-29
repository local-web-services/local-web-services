"""Given: a message has been sent to the queue"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SqsTestClient


@given("a message has been sent to the queue")
def sqs_a_message_has_been_sent_to_the_queue(lws_session):
    SqsTestClient(lws_session).create_queue()
    SqsTestClient(lws_session).send_message()
