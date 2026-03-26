"""When: a message is sent to the queue"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import SqsTestClient
from ..constants import TEST_MESSAGE


@when("a message is sent to the queue")
def send_message(lws_session, world):
    try:
        world["result"] = SqsTestClient(lws_session).send_message(
            QueueUrl=SqsTestClient(lws_session).queue_url(), MessageBody=TEST_MESSAGE
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
