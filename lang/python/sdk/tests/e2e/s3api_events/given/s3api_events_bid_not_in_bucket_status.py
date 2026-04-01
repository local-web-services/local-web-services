"""Given: bid not in bucket_status"""

from __future__ import annotations

from pytest_bdd import given


@given("bid not in bucket_status")
def s3api_events_bid_not_in_bucket_status():
    """No-op: fresh state has no buckets."""
