"""When: a queue is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import SqsTestClient
from ..constants import TEST_QUEUE


@when("a queue is created")
def create_queue(lws_session, world):
    try:
        world["result"] = SqsTestClient(lws_session).create_queue(QueueName=TEST_QUEUE)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
