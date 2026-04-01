"""When: an endpoint subscribes to a "sns" "topic" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import SnsTestClient
from ..constants import TEST_EMAIL_ENDPOINT


@when('an endpoint subscribes to a "sns" "topic"')
def subscribe_to_topic(lws_session, world):
    try:
        resp = SnsTestClient(lws_session).subscribe(
            TopicArn=world.get("topic_arn", SnsTestClient(lws_session).get_topic_arn()),
            Protocol="email",
            Endpoint=TEST_EMAIL_ENDPOINT,
        )
        world["result"] = resp
        world["subscription_arn"] = resp.get("SubscriptionArn")
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
