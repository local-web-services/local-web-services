"""Given: a "sns" "subscription" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('a "sns" "subscription" "slot" was "available"')
def sns_lambda_subscription_slot_available(lws_session):
    lws_session.capacity("sns").unlimited().apply()
