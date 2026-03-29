"""Given: the target queue is "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiSqsTestClient


@given('the target queue is "DELETED"')
def target_queue_is_deleted(lws_session, world):
    try:
        S3apiSqsTestClient(lws_session).create_queue()
    except Exception:
        pass
    lws_session.lifecycle("sqs").delete_dwell_ms(5000).apply()
    S3apiSqsTestClient(lws_session)._sqs.delete_queue(
        QueueUrl=S3apiSqsTestClient(lws_session).queue_url()
    )
    world["_target_queue_deleted"] = True
    world["result"] = None
    world["error"] = None
