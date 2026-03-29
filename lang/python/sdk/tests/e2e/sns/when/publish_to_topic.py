"""When: a message is published to a topic"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import SnsTestClient
from ..constants import TEST_MESSAGE


@when("a message is published to a topic")
def publish_to_topic(lws_session, world):
    try:
        world["result"] = SnsTestClient(lws_session).publish(
            TopicArn=world.get("topic_arn", SnsTestClient(lws_session).get_topic_arn()),
            Message=TEST_MESSAGE,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
