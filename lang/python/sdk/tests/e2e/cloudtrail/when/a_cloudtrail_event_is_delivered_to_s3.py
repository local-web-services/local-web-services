"""When: a "cloudtrail" "event" is delivered to S3"""

from __future__ import annotations

from pytest_bdd import when


@when('a "cloudtrail" "event" is delivered to S3')
def a_cloudtrail_event_is_delivered_to_s3(world):
    """Delivery to S3 is handled internally by the CloudTrail provider."""
    world["error"] = None
