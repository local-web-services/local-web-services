"""When: the "SNS" topic is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import _topic_arn


@when('the "SNS" topic is deleted')
def delete_sns_topic_apigw(lws_session, world):
    try:
        resp = lws_session.client("sns").delete_topic(TopicArn=_topic_arn())
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
