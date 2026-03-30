"""Given: message visibility timeout has been changed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SqsTestClient


@given("message visibility timeout has been changed")
def sqs_message_visibility_timeout_has_been_changed(lws_session):
    SqsTestClient(lws_session).create_queue()
    SqsTestClient(lws_session).send_message()
    msg = SqsTestClient(lws_session).receive_message()
    if msg:
        SqsTestClient(lws_session).change_message_visibility(
            QueueUrl=SqsTestClient(lws_session).queue_url(),
            ReceiptHandle=msg["ReceiptHandle"],
            VisibilityTimeout=30,
        )
