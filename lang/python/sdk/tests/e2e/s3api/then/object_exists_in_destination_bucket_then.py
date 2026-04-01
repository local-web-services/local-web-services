"""Then: the "s3" "object" will exist in the destination "s3" "bucket" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_BUCKET, TEST_KEY2


@then('the "s3" "object" will exist in the destination "s3" "bucket"')
def object_exists_in_destination_bucket_then(lws_session):
    client = lws_session.client("s3")
    resp = client.list_objects_v2(Bucket=TEST_BUCKET)
    keys = [obj["Key"] for obj in resp.get("Contents", [])]
    assert (
        TEST_KEY2 in keys
    ), f"Expected copied object '{TEST_KEY2}' to exist in destination bucket but found: {keys}"
