"""Given: the "sqs" "queue" is already "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiSqsTestClient


@given('the "sqs" "queue" is already "DELETED"')
def queue_is_already_deleted(lws_session, world):
    try:
        S3apiSqsTestClient(lws_session).create_queue()
    except Exception:
        pass
    lws_session.lifecycle("sqs").delete_dwell_ms(5000).apply()
    S3apiSqsTestClient(lws_session)._sqs.delete_queue(
        QueueUrl=S3apiSqsTestClient(lws_session).queue_url()
    )
    world["result"] = None
    world["error"] = None
