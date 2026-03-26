"""Then: the bucket is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_BUCKET


@then('the bucket is "ACTIVE"')
def bucket_is_active_then(lws_session):
    resp = lws_session.client("s3").head_bucket(Bucket=TEST_BUCKET)
    actual_status = resp["ResponseMetadata"]["HTTPStatusCode"]
    expected_status = 200
    assert (
        actual_status == expected_status
    ), f"Expected bucket HTTP status '{expected_status}' but got '{actual_status}'"
