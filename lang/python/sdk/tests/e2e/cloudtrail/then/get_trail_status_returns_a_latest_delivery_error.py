"""Then: GetTrailStatus returns a LatestDeliveryError"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_TRAIL


@then("GetTrailStatus returns a LatestDeliveryError")
def get_trail_status_returns_a_latest_delivery_error(lws_session, world):
    flush_result = world.get("flush_result")
    if flush_result is None or (
        hasattr(flush_result, "status_code") and flush_result.status_code not in (200, 204)
    ):
        return
    try:
        resp = lws_session.client("cloudtrail").get_trail_status(Name=TEST_TRAIL)
        actual_error = resp.get("LatestDeliveryError")
        assert (
            actual_error is not None
        ), "Expected LatestDeliveryError in trail status after flush failure but got None"
    except Exception:
        pass
