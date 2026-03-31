"""Given: a "sns" "message" is published to a "sns" "topic" """

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsTestClient
from ..constants import TEST_SUB_QUEUE


@given('a "sns" "message" is published to a "sns" "topic"')
def sns_a_message_has_been_published_to_a_topic(lws_session, world):
    # Arrange
    topic_arn = SnsTestClient(lws_session).create_topic()
    world["topic_arn"] = topic_arn
    sqs = lws_session.client("sqs")
    sqs.create_queue(QueueName=TEST_SUB_QUEUE)
    queue_url = lws_session.queue_url(TEST_SUB_QUEUE)
    SnsTestClient(lws_session).subscribe(TopicArn=topic_arn, Protocol="sqs", Endpoint=queue_url)
    # Act
    SnsTestClient(lws_session).publish(TopicArn=topic_arn, Message="test-message-1")
