"""Given: a "sns" "topic" is deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsTestClient


@given('a "sns" "topic" is deleted')
def sns_an_sns_topic_has_been_deleted(lws_session, world):
    try:
        world["topic_arn"] = SnsTestClient(lws_session).create_topic()
    except Exception:
        pass
    SnsTestClient(lws_session).delete_topic(
        TopicArn=world.get("topic_arn", SnsTestClient(lws_session).get_topic_arn())
    )
