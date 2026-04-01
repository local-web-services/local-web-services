"""When: CreateQueue is called on the SQS provider"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_SQS_QUEUE


@when("CreateQueue is called on the SQS provider")
def create_queue_is_called_on_the_sqs_provider(lws_session, world):
    try:
        world["result"] = lws_session.client("sqs").create_queue(QueueName=TEST_SQS_QUEUE)
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
