"""Then: the copy succeeds and the destination object exists"""

from __future__ import annotations

from pytest_bdd import then

from ..client import S3apiTestClient
from ..constants import TEST_BUCKET, TEST_KEY2


@then("the copy succeeds and the destination object exists")
def copy_succeeds_then(lws_session):
    client = S3apiTestClient(lws_session).s3()
    resp = client.list_objects_v2(Bucket=TEST_BUCKET)
    keys = [obj["Key"] for obj in resp.get("Contents", [])]
    assert TEST_KEY2 in keys, f"Expected copied object '{TEST_KEY2}' to exist but found: {keys}"
