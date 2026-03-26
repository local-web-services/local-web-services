"""When: the "SQS" queue is configured with a dead-letter queue"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import LambdaSqsTestClient
from ..constants import TEST_DLQ, TEST_QUEUE, _queue_arn


@when('the "SQS" queue is configured with a dead-letter queue')
def configure_redrive(lws_session, world):
    import json

    try:
        dlq_arn = _queue_arn(TEST_DLQ)
        redrive = json.dumps({"deadLetterTargetArn": dlq_arn, "maxReceiveCount": 2})
        LambdaSqsTestClient(lws_session)._sqs.set_queue_attributes(
            QueueUrl=LambdaSqsTestClient(lws_session).queue_url(),
            Attributes={"RedrivePolicy": redrive},
        )
        world["result"] = {"QueueName": TEST_QUEUE}
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
