"""When: the "SNS" topic is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ElasticacheSnsTestClient
from ..constants import _topic_arn


@when('the "SNS" topic is deleted')
def delete_topic(lws_session, world):
    try:
        topic_arn = _topic_arn()
        world["result"] = ElasticacheSnsTestClient(lws_session)._sns.delete_topic(
            TopicArn=topic_arn
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
