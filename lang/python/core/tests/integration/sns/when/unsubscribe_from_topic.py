"""When: an endpoint unsubscribes from a topic"""

from __future__ import annotations

from pytest_bdd import when


@when("an endpoint unsubscribes from a topic")
def unsubscribe_from_topic(client, world):
    sub_arn = world.get("subscription_arn", "invalid-subscription-arn")
    r = client.post("/", data={"Action": "Unsubscribe", "SubscriptionArn": sub_arn})
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text
