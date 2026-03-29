"""When: an "SNS" topic is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import SnsTestClient


@when('an "SNS" topic is deleted')
def delete_topic(lws_session, world):
    try:
        world["result"] = SnsTestClient(lws_session).delete_topic(
            TopicArn=world.get("topic_arn", SnsTestClient(lws_session).get_topic_arn())
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
