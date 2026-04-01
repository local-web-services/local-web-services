"""When: a "sqs" "queue" subscribes to a "sns" "topic" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import _queue_arn, _topic_arn


@when('a "sqs" "queue" subscribes to a "sns" "topic"')
def subscribe_queue_to_topic(lws_session, world):
    try:
        world["result"] = lws_session.client("sns").subscribe(
            TopicArn=_topic_arn(), Protocol="sqs", Endpoint=_queue_arn()
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
