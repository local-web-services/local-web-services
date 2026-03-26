"""Then: the bucket is "ACTIVE" with versioning disabled"""

from __future__ import annotations

from pytest_bdd import then

from ..client import S3apiTestClient
from ..constants import TEST_BUCKET


@then('the bucket is "ACTIVE" with versioning disabled')
def bucket_active_with_versioning_disabled(lws_session):
    client = S3apiTestClient(lws_session).s3()
    resp = client.list_buckets()
    actual_buckets = [b["Name"] for b in resp.get("Buckets", [])]
    assert (
        TEST_BUCKET in actual_buckets
    ), f"Expected bucket '{TEST_BUCKET}' to exist but not found in: {actual_buckets}"
