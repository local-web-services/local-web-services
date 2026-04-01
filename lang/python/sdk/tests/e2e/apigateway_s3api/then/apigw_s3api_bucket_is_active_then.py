"""Then: the "s3" "bucket" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_BUCKET


@then('the "s3" "bucket" will be "ACTIVE"')
def apigw_s3api_bucket_is_active_then(lws_session):
    resp = lws_session.client("s3").list_buckets()
    actual_buckets = [b["Name"] for b in resp.get("Buckets", [])]
    expected_bucket = TEST_BUCKET
    assert (
        expected_bucket in actual_buckets
    ), f"Expected bucket '{expected_bucket}' to be ACTIVE but not found in: {actual_buckets}"
