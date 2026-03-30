"""Given: bid not in bucket_status"""

from __future__ import annotations

from pytest_bdd import given


@given("bid not in bucket_status")
def bid_not_in_bucket_status():
    """No-op: guard condition — fresh state has no S3 buckets."""
