"""When: a caller invokes an operation that returns an AWS error"""

from __future__ import annotations

from pytest_bdd import when

_NONEXISTENT_QUEUE = "e2e-nonexistent-queue-99"
NONEXISTENT_QUEUE_URL = f"https://sqs.us-east-1.amazonaws.com/123456789012/{_NONEXISTENT_QUEUE}"


@when("a caller invokes an operation that returns an AWS error")
def a_caller_invokes_an_operation_that_returns_an_aws_error(lws_session, world):
    try:
        world["result"] = lws_session.client("sqs").get_queue_attributes(
            QueueUrl=NONEXISTENT_QUEUE_URL,
            AttributeNames=["All"],
        )
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
