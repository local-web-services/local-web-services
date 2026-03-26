"""Given: a message has been consumed from the "SQS" queue"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsSqsTestClient
from ..constants import TEST_MESSAGE


@given('a message has been consumed from the "SQS" queue')
def sns_sqs_a_message_has_been_consumed(lws_session):
    SnsSqsTestClient(lws_session).create_queue()
    url = SnsSqsTestClient(lws_session).queue_url()
    SnsSqsTestClient(lws_session)._sqs.send_message(QueueUrl=url, MessageBody=TEST_MESSAGE)
    resp = SnsSqsTestClient(lws_session)._sqs.receive_message(QueueUrl=url, MaxNumberOfMessages=1)
    messages = resp.get("Messages", [])
    if messages:
        SnsSqsTestClient(lws_session)._sqs.delete_message(
            QueueUrl=url, ReceiptHandle=messages[0]["ReceiptHandle"]
        )
