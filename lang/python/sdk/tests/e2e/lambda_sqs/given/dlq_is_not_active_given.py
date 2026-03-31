"""Given: the dead-letter queue was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSqsTestClient


@given('the dead-letter queue was not "ACTIVE"')
def dlq_is_not_active_given(lws_session, world):
    try:
        LambdaSqsTestClient(lws_session)._sqs.delete_queue(
            QueueUrl=LambdaSqsTestClient(lws_session).dlq_url()
        )
    except Exception:
        pass
    lws_session.lifecycle("sqs").create_dwell_ms(5000).apply()
    LambdaSqsTestClient(lws_session).create_dlq()
    world["result"] = None
    world["error"] = None
