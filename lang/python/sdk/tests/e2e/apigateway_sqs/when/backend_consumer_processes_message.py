"""When: a backend consumer processes the message from the queue"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewaySqsTestClient
from ..constants import TEST_QUEUE


@when("a backend consumer processes the message from the queue")
def backend_consumer_processes_message(lws_session, world):
    try:
        q_url = ApigatewaySqsTestClient(lws_session).queue_url(TEST_QUEUE)
        recv_resp = ApigatewaySqsTestClient(lws_session)._sqs.receive_message(
            QueueUrl=q_url, MaxNumberOfMessages=1
        )
        messages = recv_resp.get("Messages", [])
        if messages:
            msg = messages[0]
            ApigatewaySqsTestClient(lws_session)._sqs.delete_message(
                QueueUrl=q_url, ReceiptHandle=msg["ReceiptHandle"]
            )
            world["result"] = {"deleted": True}
            world["error"] = None
        else:
            world["result"] = {"deleted": False}
            world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
