"""Given: the dead-letter queue is not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import SqsTestClient
from ..constants import TEST_DLQ


@given('the dead-letter queue is not "ACTIVE"')
def dlq_is_not_active(lws_session):
    try:
        SqsTestClient(lws_session).delete_queue(
            QueueUrl=SqsTestClient(lws_session).queue_url(TEST_DLQ)
        )
    except Exception:
        pass
    lws_session.lifecycle("sqs").create_dwell_ms(5000).apply()
    SqsTestClient(lws_session).create_queue(QueueName=TEST_DLQ)
