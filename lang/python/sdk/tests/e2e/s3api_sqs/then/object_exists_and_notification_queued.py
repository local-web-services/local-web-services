"""Then: the object "EXISTS" and a notification message is "QUEUED" """

from __future__ import annotations

from pytest_bdd import then

from ..client import S3apiSqsTestClient
from ..constants import TEST_BUCKET, TEST_KEY


@then('the object "EXISTS" and a notification message is "QUEUED"')
def object_exists_and_notification_queued(lws_session, world):
    expected_error = None
    expected_key = TEST_KEY
    actual_error = world["error"]
    assert actual_error is expected_error, f"Expected put_object to succeed but got: {actual_error}"
    actual_objects = (
        S3apiSqsTestClient(lws_session)._s3.list_objects_v2(Bucket=TEST_BUCKET).get("Contents", [])
    )
    actual_keys = [obj["Key"] for obj in actual_objects]
    assert (
        expected_key in actual_keys
    ), f"Expected object '{expected_key}' to exist but not found in: {actual_keys}"
