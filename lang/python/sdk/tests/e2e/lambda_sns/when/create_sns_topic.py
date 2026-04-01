"""When: a "sns" "topic" is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import LambdaSnsTestClient


@when('a "sns" "topic" is created')
def create_sns_topic(lws_session, world):
    try:
        topic_arn = LambdaSnsTestClient(lws_session).create_topic()
        world["result"] = {"TopicArn": topic_arn}
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
