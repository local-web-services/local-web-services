"""Then: the object is "DELETED" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_BUCKET, TEST_KEY


@then('the object is "DELETED"')
def object_is_deleted_status_then(lws_session):
    client = lws_session.client("s3")
    resp = client.list_objects_v2(Bucket=TEST_BUCKET)
    keys = [obj["Key"] for obj in resp.get("Contents", [])]
    assert TEST_KEY not in keys, f"Expected object '{TEST_KEY}' to be deleted but found in: {keys}"
