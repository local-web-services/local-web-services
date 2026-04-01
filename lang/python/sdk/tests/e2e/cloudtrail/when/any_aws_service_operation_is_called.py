"""When: any AWS service operation is called"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_SQS_QUEUE


@when("any AWS service operation is called")
def any_aws_service_operation_is_called(lws_session, world):
    try:
        world["result"] = lws_session.client("sqs").create_queue(QueueName=f"{TEST_SQS_QUEUE}-any")
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
