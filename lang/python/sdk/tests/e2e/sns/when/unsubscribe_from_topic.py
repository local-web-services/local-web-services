"""When: an endpoint unsubscribes from a topic"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when


@when("an endpoint unsubscribes from a topic")
def unsubscribe_from_topic(lws_session, world):
    try:
        sub_arn = world.get("subscription_arn", "")
        world["result"] = lws_session.client("sns").unsubscribe(SubscriptionArn=sub_arn)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
