"""Given: the message is "IN_FLIGHT" """

from __future__ import annotations

from pytest_bdd import given

from ..client import SqsTestClient


@given('the message is "IN_FLIGHT"')
def message_is_in_flight_given(client, world):
    msg = SqsTestClient(client).receive_message()
    if msg:
        world["receipt_handle"] = msg["ReceiptHandle"]
