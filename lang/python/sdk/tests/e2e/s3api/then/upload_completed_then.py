"""Then: the upload is "COMPLETED" and the object exists"""

from __future__ import annotations

from pytest_bdd import then

from ..client import S3apiTestClient
from ..constants import TEST_BUCKET, TEST_KEY


@then('the upload is "COMPLETED" and the object exists')
def upload_completed_then(lws_session):
    client = S3apiTestClient(lws_session).s3()
    resp = client.list_objects_v2(Bucket=TEST_BUCKET)
    keys = [obj["Key"] for obj in resp.get("Contents", [])]
    assert (
        TEST_KEY in keys
    ), f"Expected completed upload object '{TEST_KEY}' to exist but found: {keys}"
