"""When: an in-flight message is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import SqsTestClient


@when("an in-flight message is deleted")
def delete_message(lws_session, world):
    try:
        world["result"] = SqsTestClient(lws_session).delete_message(
            QueueUrl=SqsTestClient(lws_session).queue_url(), ReceiptHandle=world["receipt_handle"]
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
