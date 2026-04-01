"""Given: a confirmed subscription existed for the "sns" "topic" """

from __future__ import annotations

import pytest
from pytest_bdd import given

from ..client import SnsTestClient
from ..constants import TEST_SUB_QUEUE


@given('a confirmed subscription existed for the "sns" "topic"')
def confirmed_subscription_exists(lws_session, world):
    """Subscribe using SQS queue which is auto-confirmed in lws."""
    if not world.get("topic_arn"):
        world["topic_arn"] = SnsTestClient(lws_session).create_topic()
    sqs = lws_session.client("sqs")
    sqs.create_queue(QueueName=TEST_SUB_QUEUE)
    queue_url = lws_session.queue_url(TEST_SUB_QUEUE)
    resp = SnsTestClient(lws_session).subscribe(
        TopicArn=world["topic_arn"], Protocol="sqs", Endpoint=queue_url
    )
    sub_arn = resp.get("SubscriptionArn", "")
    if sub_arn == "PendingConfirmation":
        pytest.skip("SQS subscription not auto-confirmed in this lws version")
    world["subscription_arn"] = sub_arn
