"""When: a message is consumed from the "sqs" "queue" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import SnsSqsTestClient
from ..constants import TEST_QUEUE


@when('a message is consumed from the "sqs" "queue"')
def consume_message(lws_session, world):
    try:
        url = SnsSqsTestClient(lws_session).queue_url()
        resp = lws_session.client("sqs").receive_message(QueueUrl=url, MaxNumberOfMessages=1)
        messages = resp.get("Messages", [])
        if not messages:
            raise ValueError(f"No messages available in queue '{TEST_QUEUE}'")
        receipt_handle = messages[0]["ReceiptHandle"]
        lws_session.client("sqs").delete_message(QueueUrl=url, ReceiptHandle=receipt_handle)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
