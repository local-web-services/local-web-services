"""Given: an "AVAILABLE" "sns" "message" existed on the "sns" "topic" """

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsSnsTestClient
from ..constants import TEST_MESSAGE


@given('an "AVAILABLE" "sns" "message" existed on the "sns" "topic"')
def available_message_exists_on_topic(lws_session):
    topic_arn = EventsSnsTestClient(lws_session).create_topic()
    EventsSnsTestClient(lws_session)._sns.subscribe(
        TopicArn=topic_arn,
        Protocol="https",
        Endpoint="https://example.com",
    )
    EventsSnsTestClient(lws_session)._sns.publish(TopicArn=topic_arn, Message=TEST_MESSAGE)
