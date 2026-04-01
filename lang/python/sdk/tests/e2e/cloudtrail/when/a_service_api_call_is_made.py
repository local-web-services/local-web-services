"""When: a service API call is made"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_SQS_QUEUE


@when("a service API call is made")
def a_service_api_call_is_made(lws_session, world):
    try:
        world["result"] = lws_session.client("sqs").create_queue(QueueName=f"{TEST_SQS_QUEUE}-api")
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
