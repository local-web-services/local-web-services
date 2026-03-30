"""Then: the "API" will enqueue incoming requests as "SQS" messages without invoking Lambda"""

from __future__ import annotations

from pytest_bdd import then

from ..client import ApigatewaySqsTestClient


@then('the "API" will enqueue incoming requests as "SQS" messages without invoking Lambda')
def api_will_enqueue_requests(lws_session, world):
    api_id = world.get("api_id") or ApigatewaySqsTestClient(lws_session).get_api_id()
    assert api_id is not None, "Expected API to exist"
    resp = ApigatewaySqsTestClient(lws_session).invoke_api(
        api_id, {"event": "check", "orderId": "check-1"}
    )
    expected_status = 200
    actual_status = resp["status_code"]
    assert (
        actual_status == expected_status
    ), f"Expected status {expected_status!r} but got {actual_status!r}: {resp['body']}"
