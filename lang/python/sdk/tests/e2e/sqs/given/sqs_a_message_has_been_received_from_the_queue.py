"""Given: a message has been received from the queue"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SqsTestClient


@given("a message has been received from the queue")
def sqs_a_message_has_been_received_from_the_queue(lws_session):
    SqsTestClient(lws_session).create_queue()
    SqsTestClient(lws_session).send_message()
    SqsTestClient(lws_session).receive_message()
