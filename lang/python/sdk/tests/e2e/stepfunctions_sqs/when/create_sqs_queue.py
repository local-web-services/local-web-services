"""When: an "SQS" queue is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import StepfunctionsSqsTestClient
from ..constants import TEST_QUEUE


@when('an "SQS" queue is created')
def create_sqs_queue(lws_session, world):
    try:
        world["result"] = StepfunctionsSqsTestClient(lws_session)._sqs.create_queue(
            QueueName=TEST_QUEUE
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
