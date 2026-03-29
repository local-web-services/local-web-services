"""When: the "SQS" queue is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import S3apiSqsTestClient


@when('the "SQS" queue is deleted')
def delete_sqs_queue(lws_session, world):
    try:
        url = S3apiSqsTestClient(lws_session).queue_url()
        world["result"] = lws_session.client("sqs").delete_queue(QueueUrl=url)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
