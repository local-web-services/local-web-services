"""Given: an endpoint has subscribed to a topic"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsTestClient
from ..constants import TEST_EMAIL_ENDPOINT


@given("an endpoint has subscribed to a topic")
def sns_an_endpoint_has_subscribed_to_a_topic(lws_session, world):
    world["topic_arn"] = SnsTestClient(lws_session).create_topic()
    resp = SnsTestClient(lws_session).subscribe(
        TopicArn=world["topic_arn"], Protocol="email", Endpoint=TEST_EMAIL_ENDPOINT
    )
    world["subscription_arn"] = resp.get("SubscriptionArn", "PendingConfirmation")
