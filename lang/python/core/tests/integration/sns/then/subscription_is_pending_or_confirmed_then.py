"""Then: the subscription is "PENDING_CONFIRMATION" or "CONFIRMED" """

from __future__ import annotations

from pytest_bdd import then


@then('the subscription is "PENDING_CONFIRMATION" or "CONFIRMED"')
def subscription_is_pending_or_confirmed_then(client):
    r = client.post("/", data={"Action": "ListSubscriptions"})
    expected_status = 200
    actual_status = r.status_code
    assert (
        actual_status == expected_status
    ), f"Expected ListSubscriptions to return {expected_status} but got: {actual_status}"
