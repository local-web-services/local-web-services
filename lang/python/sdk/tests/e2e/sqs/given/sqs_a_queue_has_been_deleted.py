"""Given: a queue has been deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SqsTestClient


@given("a queue has been deleted")
def sqs_a_queue_has_been_deleted(lws_session):
    try:
        SqsTestClient(lws_session).create_queue()
    except Exception:
        pass
    SqsTestClient(lws_session).delete_queue(QueueUrl=SqsTestClient(lws_session).queue_url())
