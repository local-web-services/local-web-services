"""When: all messages in a queue are purged"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import SqsTestClient


@when("all messages in a queue are purged")
def purge_queue(lws_session, world):
    try:
        world["result"] = SqsTestClient(lws_session).purge_queue(
            QueueUrl=SqsTestClient(lws_session).queue_url()
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
