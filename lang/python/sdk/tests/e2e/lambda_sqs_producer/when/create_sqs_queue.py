"""When: an "SQS" queue is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import LambdaSqsProducerTestClient
from ..constants import TEST_QUEUE


@when('an "SQS" queue is created')
def create_sqs_queue(lws_session, world):
    try:
        LambdaSqsProducerTestClient(lws_session).create_queue()
        world["result"] = {"QueueName": TEST_QUEUE}
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
