"""Given: the "sqs" "queue" is configured with a dead-letter queue"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSqsTestClient
from ..constants import TEST_DLQ, _queue_arn


@given('the "sqs" "queue" is configured with a dead-letter queue')
def sqs_queue_configured_with_dlq_seq(lws_session):
    import json

    try:
        LambdaSqsTestClient(lws_session).create_queue()
    except Exception:
        pass
    try:
        LambdaSqsTestClient(lws_session).create_dlq()
    except Exception:
        pass
    dlq_arn = _queue_arn(TEST_DLQ)
    redrive = json.dumps({"deadLetterTargetArn": dlq_arn, "maxReceiveCount": 2})
    LambdaSqsTestClient(lws_session)._sqs.set_queue_attributes(
        QueueUrl=LambdaSqsTestClient(lws_session).queue_url(),
        Attributes={"RedrivePolicy": redrive},
    )
