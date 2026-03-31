"""When: a "sqs" "message" visibility timeout expires"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import SqsTestClient


@when('a "sqs" "message" visibility timeout expires')
def visibility_timeout_expires(lws_session, world):
    """Simulate by setting visibility timeout to 0 (makes message AVAILABLE again)."""
    try:
        world["result"] = SqsTestClient(lws_session).change_message_visibility(
            QueueUrl=SqsTestClient(lws_session).queue_url(),
            ReceiptHandle=world["receipt_handle"],
            VisibilityTimeout=0,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
