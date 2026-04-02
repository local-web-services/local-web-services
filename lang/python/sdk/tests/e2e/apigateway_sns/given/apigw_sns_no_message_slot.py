"""Given: no "sns" "message" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('no "sns" "message" "slot" was "available"')
def apigw_sns_no_message_slot(lws_session):
    lws_session.capacity("sns").exhaust().apply()
