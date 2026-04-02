"""Given: a "sns" "message" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('a "sns" "message" "slot" was "available"')
def glacier_sns_message_slot_available(lws_session):
    lws_session.capacity("sns").unlimited().apply()
