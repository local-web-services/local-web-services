"""When: a "sqs" "message" is sent to the "sqs" "queue" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import SqsTestClient
from ..constants import TEST_MESSAGE


@when('a "sqs" "message" is sent to the "sqs" "queue"')
def send_message(lws_session, world):
    try:
        world["result"] = lws_session.client("sqs").send_message(
            QueueUrl=SqsTestClient(lws_session).queue_url(), MessageBody=TEST_MESSAGE
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
