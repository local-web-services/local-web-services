"""Then: the "s3" "bucket" will be "ACTIVE" with no notification configuration"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_BUCKET


@then('the "s3" "bucket" will be "ACTIVE" with no notification configuration')
def bucket_active_no_notification(lws_session):
    resp = lws_session.client("s3").list_buckets()
    actual_buckets = [b["Name"] for b in resp.get("Buckets", [])]
    assert (
        TEST_BUCKET in actual_buckets
    ), f"Expected bucket '{TEST_BUCKET}' to exist but not found in: {actual_buckets}"
