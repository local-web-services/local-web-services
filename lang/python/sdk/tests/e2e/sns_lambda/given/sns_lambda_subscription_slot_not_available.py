"""Given: no "sns" "subscription" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('no "sns" "subscription" "slot" was "available"')
def sns_lambda_subscription_slot_not_available(lws_session):
    lws_session.capacity("sns").exhaust().apply()
