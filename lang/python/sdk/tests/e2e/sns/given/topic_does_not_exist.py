"""Given: the topic does not exist"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsTestClient


@given("the topic does not exist")
def topic_does_not_exist(lws_session, world):
    """Ensure the topic does not exist by deleting it if present."""
    client = SnsTestClient(lws_session)
    topic_arn = world.get("topic_arn") or SnsTestClient(lws_session).get_topic_arn()
    try:
        client.delete_topic(TopicArn=topic_arn)
    except Exception:
        pass
