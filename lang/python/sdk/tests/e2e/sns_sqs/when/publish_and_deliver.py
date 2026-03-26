"""When: a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import SnsSqsTestClient
from ..constants import TEST_MESSAGE, _topic_arn


@when('a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue')
def publish_and_deliver(lws_session, world):
    try:
        world["result"] = SnsSqsTestClient(lws_session)._sns.publish(
            TopicArn=_topic_arn(), Message=TEST_MESSAGE
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
