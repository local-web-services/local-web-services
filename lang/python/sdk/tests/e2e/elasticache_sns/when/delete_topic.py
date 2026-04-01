"""When: the "sns" "topic" is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import _topic_arn


@when('the "sns" "topic" is deleted')
def delete_topic(lws_session, world):
    try:
        topic_arn = _topic_arn()
        world["result"] = lws_session.client("sns").delete_topic(TopicArn=topic_arn)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
