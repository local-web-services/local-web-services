"""Then: the "s3" "object" will exist in the "s3" "bucket" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_BUCKET, TEST_KEY


@then('the "s3" "object" will exist in the "s3" "bucket"')
def object_exists_in_bucket_then(lws_session):
    client = lws_session.client("s3")
    resp = client.list_objects_v2(Bucket=TEST_BUCKET)
    keys = [obj["Key"] for obj in resp.get("Contents", [])]
    assert TEST_KEY in keys, f"Expected object '{TEST_KEY}' to exist in bucket but found: {keys}"
