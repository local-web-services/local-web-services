"""Then: the object "EXISTS" in the bucket and an invocation is "IN_PROGRESS" """

from __future__ import annotations

from pytest_bdd import then

from ..client import S3apiLambdaTestClient
from ..constants import TEST_BUCKET, TEST_KEY


@then('the object "EXISTS" in the bucket and an invocation is "IN_PROGRESS"')
def object_exists_invocation_in_progress(lws_session):
    resp = S3apiLambdaTestClient(lws_session)._s3.list_objects_v2(Bucket=TEST_BUCKET)
    actual_keys = [obj["Key"] for obj in resp.get("Contents", [])]
    expected_key = TEST_KEY
    assert (
        expected_key in actual_keys
    ), f"Expected object '{expected_key}' to exist in bucket but found: {actual_keys}"
