"""Given: the queue is not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import SqsTestClient
from ..constants import TEST_QUEUE


@given('the queue is not "ACTIVE"')
def queue_is_not_active_given(lws_session):
    try:
        SqsTestClient(lws_session).delete_queue(QueueUrl=SqsTestClient(lws_session).queue_url())
    except Exception:
        pass
    lws_session.lifecycle("sqs").create_dwell_ms(5000).apply()
    SqsTestClient(lws_session).create_queue(QueueName=TEST_QUEUE)
