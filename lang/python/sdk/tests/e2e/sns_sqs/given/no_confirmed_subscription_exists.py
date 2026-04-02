"""Given: no "sns" "subscription" was "CONFIRMED" for the "sns" "topic" """

from __future__ import annotations

from pytest_bdd import given


@given('no "confirmed" "subscription" existed for the "sns" "topic"')
@given('no "sns" "subscription" was "CONFIRMED" for the "sns" "topic"')
def no_confirmed_subscription_exists(world):
    world["result"] = None
    world["error"] = None
