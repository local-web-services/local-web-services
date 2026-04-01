"""When: multiple service API calls are made"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_SQS_QUEUE


@when("multiple service API calls are made")
def multiple_service_api_calls_are_made(lws_session, world):
    sqs = lws_session.client("sqs")
    try:
        sqs.create_queue(QueueName=f"{TEST_SQS_QUEUE}-multi-1")
        sqs.create_queue(QueueName=f"{TEST_SQS_QUEUE}-multi-2")
        world["error"] = None
    except Exception as exc:
        world["error"] = exc
