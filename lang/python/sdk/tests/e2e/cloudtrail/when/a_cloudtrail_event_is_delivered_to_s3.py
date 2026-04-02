"""When: a "cloudtrail" "event" is delivered to S3"""

from __future__ import annotations

from pytest_bdd import when


@when('a "cloudtrail" "event" is delivered to S3')
def a_cloudtrail_event_is_delivered_to_s3(world):
    """Delivery to S3 is handled internally by the CloudTrail provider."""
    if world.get("event_exists") is False:
        world["result"] = None
        world["error"] = ValueError("Guard: event does not exist")
        return
    if world.get("event_buffered") is False:
        world["result"] = None
        world["error"] = ValueError("Guard: event is not in BUFFERED state")
        return
    world["error"] = None
