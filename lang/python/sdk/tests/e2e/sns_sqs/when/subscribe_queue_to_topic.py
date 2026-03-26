"""When: an "SQS" queue subscribes to an "SNS" topic"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import SnsSqsTestClient
from ..constants import _queue_arn, _topic_arn


@when('an "SQS" queue subscribes to an "SNS" topic')
def subscribe_queue_to_topic(lws_session, world):
    try:
        world["result"] = SnsSqsTestClient(lws_session)._sns.subscribe(
            TopicArn=_topic_arn(), Protocol="sqs", Endpoint=_queue_arn()
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
