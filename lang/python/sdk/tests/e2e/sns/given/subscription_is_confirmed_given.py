"""Given: the "sns" "subscription" was "CONFIRMED" """

from __future__ import annotations

import pytest
from pytest_bdd import given

from ..client import SnsTestClient
from ..constants import TEST_SUB_QUEUE


@given('the "sns" "subscription" was "CONFIRMED"')
def subscription_is_confirmed_given(lws_session, world):
    """Set up a confirmed SQS subscription (auto-confirmed in lws)."""
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
