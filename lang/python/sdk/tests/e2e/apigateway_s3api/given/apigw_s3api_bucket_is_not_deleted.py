"""Given: the bucket is not "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the bucket is not "DELETED"')
def apigw_s3api_bucket_is_not_deleted():
    """No-op: buckets are not DELETED by default."""
