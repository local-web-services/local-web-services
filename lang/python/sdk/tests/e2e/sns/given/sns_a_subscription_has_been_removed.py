"""Given: a "sns" "subscription" is removed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsTestClient


@given('a "sns" "subscription" is removed')
def sns_a_subscription_has_been_removed(lws_session, world):
    sub_arn = world.get("subscription_arn", "")
    if sub_arn:
        try:
            SnsTestClient(lws_session).unsubscribe(SubscriptionArn=sub_arn)
        except Exception:
            pass
