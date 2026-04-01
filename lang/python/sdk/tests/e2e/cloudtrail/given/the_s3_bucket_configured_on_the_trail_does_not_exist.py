"""Given: the S3 bucket configured on the trail does not exist"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_BUCKET_2, TEST_TRAIL


@given("the S3 bucket configured on the trail does not exist")
def the_s3_bucket_configured_on_the_trail_does_not_exist(lws_session):
    # Arrange: update the trail to point at a non-existent bucket
    lws_session.client("cloudtrail").update_trail(Name=TEST_TRAIL, S3BucketName=TEST_BUCKET_2)
