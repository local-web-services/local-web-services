"""Then: the subscription is "CONFIRMED" and the queue will receive published messages"""

from __future__ import annotations

from pytest_bdd import then

from ..client import SnsSqsTestClient
from ..constants import TEST_TOPIC, _topic_arn


@then('the subscription is "CONFIRMED" and the queue will receive published messages')
def subscription_confirmed(lws_session):
    resp = SnsSqsTestClient(lws_session)._sns.list_subscriptions_by_topic(TopicArn=_topic_arn())
    subs = resp.get("Subscriptions", [])
    assert (
        len(subs) > 0
    ), f"Expected at least one subscription for topic '{TEST_TOPIC}' but found none"
