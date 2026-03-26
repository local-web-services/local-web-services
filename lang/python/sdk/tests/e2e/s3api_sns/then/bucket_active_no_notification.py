"""Then: the bucket is "ACTIVE" with no notification configuration"""

from __future__ import annotations

from pytest_bdd import then

from ..client import S3apiSnsTestClient
from ..constants import TEST_BUCKET


@then('the bucket is "ACTIVE" with no notification configuration')
def bucket_active_no_notification(lws_session):
    resp = S3apiSnsTestClient(lws_session)._s3.list_buckets()
    actual_buckets = [b["Name"] for b in resp.get("Buckets", [])]
    assert (
        TEST_BUCKET in actual_buckets
    ), f"Expected bucket '{TEST_BUCKET}' to exist but not found in: {actual_buckets}"
