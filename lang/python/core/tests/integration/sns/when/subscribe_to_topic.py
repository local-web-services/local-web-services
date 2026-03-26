"""When: an endpoint subscribes to a topic"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_EMAIL_ENDPOINT, TEST_TOPIC_ARN, _extract_xml_tag


@when("an endpoint subscribes to a topic")
def subscribe_to_topic(client, world):
    topic_arn = world.get("topic_arn", TEST_TOPIC_ARN)
    r = client.post(
        "/",
        data={
            "Action": "Subscribe",
            "TopicArn": topic_arn,
            "Protocol": "email",
            "Endpoint": TEST_EMAIL_ENDPOINT,
        },
    )
    if r.status_code == 200:
        world["result"] = r.text
        world["subscription_arn"] = _extract_xml_tag(r.text, "SubscriptionArn")
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text
