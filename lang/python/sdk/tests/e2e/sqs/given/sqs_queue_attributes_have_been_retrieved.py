"""Given: queue attributes have been retrieved"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SqsTestClient


@given("queue attributes have been retrieved")
def sqs_queue_attributes_have_been_retrieved(lws_session):
    SqsTestClient(lws_session).create_queue()
    SqsTestClient(lws_session).get_queue_attributes(
        QueueUrl=SqsTestClient(lws_session).queue_url(), AttributeNames=["All"]
    )
