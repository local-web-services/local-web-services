"""Given: the target queue was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewaySqsTestClient
from ..constants import TEST_QUEUE


@given('the target queue was not "ACTIVE"')
def apigw_sqs_target_queue_is_not_active(lws_session, world):
    try:
        url = lws_session.queue_url(TEST_QUEUE)
        lws_session.client("sqs").delete_queue(QueueUrl=url)
    except Exception:
        pass
    lws_session.lifecycle("sqs").create_dwell_ms(5000).apply()
    ApigatewaySqsTestClient(lws_session).create_queue()
    world["result"] = None
    world["error"] = None
