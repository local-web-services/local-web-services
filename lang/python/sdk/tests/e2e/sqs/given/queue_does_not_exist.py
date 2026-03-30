"""Given: the queue does not exist"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SqsTestClient


@given("the queue does not exist")
def queue_does_not_exist(lws_session):
    """Ensure the queue does not exist by deleting it if present."""
    client = SqsTestClient(lws_session)
    try:
        client.delete_queue(QueueUrl=SqsTestClient(lws_session).queue_url())
    except Exception:
        pass
