"""Given: an in-flight message has been deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SqsTestClient


@given("an in-flight message has been deleted")
def sqs_an_in_flight_message_has_been_deleted(lws_session):
    SqsTestClient(lws_session).create_queue()
    SqsTestClient(lws_session).send_message()
    msg = SqsTestClient(lws_session).receive_message()
    if msg:
        SqsTestClient(lws_session).delete_message(
            QueueUrl=SqsTestClient(lws_session).queue_url(), ReceiptHandle=msg["ReceiptHandle"]
        )
