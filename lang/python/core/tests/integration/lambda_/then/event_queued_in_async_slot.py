"""Then: the event is queued in an async slot"""

from __future__ import annotations

from pytest_bdd import then


@then("the event is queued in an async slot")
def event_queued_in_async_slot(world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected async invocation to be queued but got: {actual_error}"
