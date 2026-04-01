"""When: a service operation is called"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_SQS_QUEUE


@when("a service operation is called")
def a_service_operation_is_called(lws_session, world):
    try:
        world["result"] = lws_session.client("sqs").create_queue(QueueName=f"{TEST_SQS_QUEUE}-svc")
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
