"""When: a queue is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import SqsTestClient


@when("a queue is deleted")
def delete_queue(lws_session, world):
    try:
        world["result"] = SqsTestClient(lws_session).delete_queue(
            QueueUrl=SqsTestClient(lws_session).queue_url()
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
