"""Then: the trail's S3 bucket is updated"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_BUCKET_2, TEST_TRAIL


@then("the trail's S3 bucket is updated")
def the_trails_s3_bucket_is_updated(lws_session):
    resp = lws_session.client("cloudtrail").get_trail(Name=TEST_TRAIL)
    actual_bucket = resp["Trail"]["S3BucketName"]
    expected_bucket = TEST_BUCKET_2
    assert (
        actual_bucket == expected_bucket
    ), f"Expected S3BucketName '{expected_bucket}' but got '{actual_bucket}'"
