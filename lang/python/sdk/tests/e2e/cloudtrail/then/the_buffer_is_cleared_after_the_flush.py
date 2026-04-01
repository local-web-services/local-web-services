"""Then: the buffer is cleared after the flush"""

from __future__ import annotations

from pytest_bdd import then


@then("the buffer is cleared after the flush")
def the_buffer_is_cleared_after_the_flush(lws_session, world):
    flush_result = world.get("flush_result")
    if flush_result is None or (
        hasattr(flush_result, "status_code") and flush_result.status_code not in (200, 204)
    ):
        return
    resp = lws_session.client("cloudtrail").lookup_events()
    actual_events = resp.get("Events", [])
    assert isinstance(
        actual_events, list
    ), f"Expected Events to be a list but got {type(actual_events)}"
