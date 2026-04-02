"""Given: the target "sqs" "queue" was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsSqsTestClient


@given('the target "sqs" "queue" was not "ACTIVE"')
def target_queue_is_not_active(lws_session, world):
    try:
        EventsSqsTestClient(lws_session)._sqs.delete_queue(
            QueueUrl=EventsSqsTestClient(lws_session).queue_url()
        )
    except Exception:
        pass
    lws_session.lifecycle("sqs").create_dwell_ms(5000).apply()
    EventsSqsTestClient(lws_session).create_queue()
    world["result"] = None
    world["error"] = None
