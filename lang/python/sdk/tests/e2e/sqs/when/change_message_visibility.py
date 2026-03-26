"""When: message visibility timeout is changed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import SqsTestClient


@when("message visibility timeout is changed")
def change_message_visibility(lws_session, world):
    try:
        world["result"] = SqsTestClient(lws_session).change_message_visibility(
            QueueUrl=SqsTestClient(lws_session).queue_url(),
            ReceiptHandle=world["receipt_handle"],
            VisibilityTimeout=60,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
