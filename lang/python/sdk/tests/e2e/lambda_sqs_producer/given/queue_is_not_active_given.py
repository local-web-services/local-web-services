"""Given: the "sqs" "queue" was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSqsProducerTestClient


@given('the "sqs" "queue" was not "ACTIVE"')
def queue_is_not_active_given(lws_session, world):
    try:
        LambdaSqsProducerTestClient(lws_session)._sqs.delete_queue(
            QueueUrl=LambdaSqsProducerTestClient(lws_session).queue_url()
        )
    except Exception:
        pass
    lws_session.lifecycle("sqs").create_dwell_ms(5000).apply()
    LambdaSqsProducerTestClient(lws_session).create_queue()
    world["result"] = None
    world["error"] = None
