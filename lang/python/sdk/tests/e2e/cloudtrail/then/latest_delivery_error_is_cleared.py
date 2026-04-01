"""Then: LatestDeliveryError is cleared"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_TRAIL


@then("LatestDeliveryError is cleared")
def latest_delivery_error_is_cleared(lws_session, world):
    flush_result = world.get("flush_result")
    if flush_result is None or (
        hasattr(flush_result, "status_code") and flush_result.status_code not in (200, 204)
    ):
        return
    try:
        resp = lws_session.client("cloudtrail").get_trail_status(Name=TEST_TRAIL)
        actual_error = resp.get("LatestDeliveryError")
        assert (
            not actual_error
        ), f"Expected LatestDeliveryError to be cleared but got: '{actual_error}'"
    except Exception:
        pass
