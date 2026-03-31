"""When: a "sns" "subscription" is removed"""

from __future__ import annotations

from pytest_bdd import when


@when('a "sns" "subscription" is removed')
def subscription_removed(client, world):
    sub_arn = world.get("subscription_arn", "invalid-subscription-arn")
    r = client.post("/", data={"Action": "Unsubscribe", "SubscriptionArn": sub_arn})
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text
