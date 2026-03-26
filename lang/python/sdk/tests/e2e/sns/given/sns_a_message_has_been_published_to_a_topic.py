"""Given: a message has been published to a topic"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsTestClient


@given("a message has been published to a topic")
def sns_a_message_has_been_published_to_a_topic(lws_session, world):
    world["topic_arn"] = SnsTestClient(lws_session).create_topic()
    SnsTestClient(lws_session).publish(TopicArn=world["topic_arn"], Message="test-message-1")
