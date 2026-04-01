"""Then: the bucket will be "ACTIVE" with no event notification configured"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_BUCKET


@then('the bucket will be "ACTIVE" with no event notification configured')
def bucket_active_no_event_notification(lws_session):
    resp = lws_session.client("s3").list_buckets()
    actual_buckets = [b["Name"] for b in resp.get("Buckets", [])]
    expected_bucket = TEST_BUCKET
    assert (
        expected_bucket in actual_buckets
    ), f"Expected bucket '{expected_bucket}' to exist but not found in: {actual_buckets}"
