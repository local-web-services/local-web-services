"""When: queue attributes are retrieved"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import SqsTestClient


@when("queue attributes are retrieved")
def get_queue_attributes(lws_session, world):
    try:
        world["result"] = SqsTestClient(lws_session).get_queue_attributes(
            QueueUrl=SqsTestClient(lws_session).queue_url(), AttributeNames=["All"]
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
