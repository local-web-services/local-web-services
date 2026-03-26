"""When: a message is received from the queue"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import SqsTestClient


@when("a message is received from the queue")
def receive_message(lws_session, world):
    try:
        resp = lws_session.client("sqs").receive_message(
            QueueUrl=SqsTestClient(lws_session).queue_url(),
            MaxNumberOfMessages=1,
            VisibilityTimeout=30,
            WaitTimeSeconds=0,
        )
        world["result"] = resp
        world["error"] = None
        msgs = resp.get("Messages", [])
        if msgs:
            world["receipt_handle"] = msgs[0]["ReceiptHandle"]
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
