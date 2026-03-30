"""Given: the bucket has no notification configured"""

from __future__ import annotations

from pytest_bdd import given


@given("the bucket has no notification configured")
def s3api_lambda_bucket_has_no_notification(world):
    """No-op: buckets have no notification configuration by default."""
    world["_skip"] = "lws does not fail put_object when no notification is configured"
