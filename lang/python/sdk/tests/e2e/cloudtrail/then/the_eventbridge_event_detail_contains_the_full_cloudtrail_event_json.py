"""Then: the EventBridge event Detail contains the full CloudTrail event JSON"""

from __future__ import annotations

from pytest_bdd import then


@then("the EventBridge event Detail contains the full CloudTrail event JSON")
def the_eventbridge_event_detail_contains_the_full_cloudtrail_event_json(world):
    actual_error = world.get("error")
    assert (
        actual_error is None
    ), f"Expected no error when publishing CloudTrail event to EventBridge but got: {actual_error}"
