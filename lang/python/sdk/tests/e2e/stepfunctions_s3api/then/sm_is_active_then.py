"""Then: the "s3" "bucket" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_BUCKET


@then('the "s3" "bucket" will be "ACTIVE"')
def sm_is_active_then(lws_session):
    resp = lws_session.client("s3").list_buckets()
    actual_buckets = [b["Name"] for b in resp.get("Buckets", [])]
    assert (
        TEST_BUCKET in actual_buckets
    ), f"Expected S3 bucket '{TEST_BUCKET}' to exist but found: {actual_buckets}"
