"""Then: the "s3" "object" was "deleted" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_BUCKET


@then('the "s3" "object" was "deleted"')
def bucket_is_deleted_status_then(lws_session):
    client = lws_session.client("s3")
    resp = client.list_buckets()
    actual_buckets = [b["Name"] for b in resp.get("Buckets", [])]
    assert (
        TEST_BUCKET not in actual_buckets
    ), f"Expected bucket '{TEST_BUCKET}' to be deleted but found in: {actual_buckets}"
