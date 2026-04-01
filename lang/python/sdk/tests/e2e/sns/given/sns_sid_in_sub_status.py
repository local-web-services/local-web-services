"""Given: sid in sub_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsTestClient
from ..constants import TEST_EMAIL_ENDPOINT


@given("sid in sub_status")
def sns_sid_in_sub_status(lws_session, world):
    if not world.get("topic_arn"):
        world["topic_arn"] = SnsTestClient(lws_session).create_topic()
    resp = SnsTestClient(lws_session).subscribe(
        TopicArn=world["topic_arn"], Protocol="email", Endpoint=TEST_EMAIL_ENDPOINT
    )
    world["subscription_arn"] = resp.get("SubscriptionArn", "PendingConfirmation")
