"""Given: the queue is not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSqsTestClient


@given('the queue is not "ACTIVE"')
def queue_is_not_active_given(lws_session, world):
    try:
        StepfunctionsSqsTestClient(lws_session)._sqs.delete_queue(
            QueueUrl=StepfunctionsSqsTestClient(lws_session).queue_url()
        )
    except Exception:
        pass
    lws_session.lifecycle("sqs").create_dwell_ms(5000).apply()
    StepfunctionsSqsTestClient(lws_session).create_queue()
    world["result"] = None
    world["error"] = None
