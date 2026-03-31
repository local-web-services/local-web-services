"""Given: the "sqs" "message" was "IN_FLIGHT" """

from __future__ import annotations

from pytest_bdd import given

from ..client import SqsTestClient


@given('the "sqs" "message" was "IN_FLIGHT"')
def message_is_in_flight_given(lws_session, world):
    msg = SqsTestClient(lws_session).receive_message()
    if msg:
        world["receipt_handle"] = msg["ReceiptHandle"]
