"""Given: the bucket is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the bucket is "ACTIVE"')
def s3api_lambda_bucket_is_active_given():
    """No-op: buckets are ACTIVE by default after creation."""
