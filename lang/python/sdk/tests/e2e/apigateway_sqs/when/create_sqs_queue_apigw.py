"""When: an "SQS" queue is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_QUEUE


@when('an "SQS" queue is created')
def create_sqs_queue_apigw(lws_session, world):
    try:
        resp = lws_session.client("sqs").create_queue(QueueName=TEST_QUEUE)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
