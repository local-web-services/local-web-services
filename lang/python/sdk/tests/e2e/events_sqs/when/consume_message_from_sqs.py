"""When: a message is consumed from the "SQS" queue"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import EventsSqsTestClient


@when('a message is consumed from the "SQS" queue')
def consume_message_from_sqs(lws_session, world):
    try:
        resp = lws_session.client("sqs").receive_message(
            QueueUrl=EventsSqsTestClient(lws_session).queue_url(),
            MaxNumberOfMessages=1,
            WaitTimeSeconds=0,
        )
        msgs = resp.get("Messages", [])
        if msgs:
            lws_session.client("sqs").delete_message(
                QueueUrl=EventsSqsTestClient(lws_session).queue_url(),
                ReceiptHandle=msgs[0]["ReceiptHandle"],
            )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
