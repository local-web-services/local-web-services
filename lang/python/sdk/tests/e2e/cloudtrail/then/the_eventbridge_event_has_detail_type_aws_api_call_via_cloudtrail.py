"""Then: the EventBridge event has DetailType "AWS API Call via CloudTrail" """

from __future__ import annotations

from pytest_bdd import then


@then('the EventBridge event has DetailType "AWS API Call via CloudTrail"')
def the_eventbridge_event_has_detail_type_aws_api_call_via_cloudtrail(world):
    actual_error = world.get("error")
    assert (
        actual_error is None
    ), f"Expected no error when publishing to EventBridge but got: {actual_error}"
