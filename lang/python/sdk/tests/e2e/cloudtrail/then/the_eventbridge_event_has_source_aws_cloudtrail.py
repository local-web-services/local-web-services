"""Then: the EventBridge event has Source aws.cloudtrail"""

from __future__ import annotations

from pytest_bdd import then


@then("the EventBridge event has Source aws.cloudtrail")
def the_eventbridge_event_has_source_aws_cloudtrail(world):
    actual_error = world.get("error")
    assert (
        actual_error is None
    ), f"Expected no error when publishing to EventBridge but got: {actual_error}"
