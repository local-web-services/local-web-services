"""Then: only events with S3 bucket resources are returned"""

from __future__ import annotations

import json

from pytest_bdd import then


@then("only events with S3 bucket resources are returned")
def only_events_with_s3_bucket_resources_are_returned(world):
    actual_result = world.get("result")
    assert actual_result is not None, "Expected LookupEvents result but got None"
    actual_events = actual_result.get("Events", [])
    for event in actual_events:
        cloud_trail_event = event.get("CloudTrailEvent", "{}")
        if isinstance(cloud_trail_event, str):
            event_data = json.loads(cloud_trail_event)
        else:
            event_data = cloud_trail_event
        actual_resources = event_data.get("resources", []) or event.get("Resources", [])
        has_s3_bucket = any(
            r.get("type") == "AWS::S3::Bucket" or r.get("ResourceType") == "AWS::S3::Bucket"
            for r in actual_resources
        )
        assert (
            has_s3_bucket or event_data.get("eventSource") == "s3.amazonaws.com"
        ), "Expected only S3 bucket resource events but found event without S3 bucket resource"
