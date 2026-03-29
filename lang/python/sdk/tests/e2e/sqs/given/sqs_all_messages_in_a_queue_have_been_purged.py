"""Given: all messages in a queue have been purged"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SqsTestClient


@given("all messages in a queue have been purged")
def sqs_all_messages_in_a_queue_have_been_purged(lws_session):
    SqsTestClient(lws_session).create_queue()
    SqsTestClient(lws_session).send_message()
    SqsTestClient(lws_session).purge_queue(QueueUrl=SqsTestClient(lws_session).queue_url())
