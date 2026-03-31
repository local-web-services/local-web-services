"""Given: a "s3" "object" is copied from one "s3" "bucket" to another"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient
from ..constants import TEST_BUCKET, TEST_KEY, TEST_KEY2, TEST_SRC_BUCKET


@given('a "s3" "object" is copied from one "s3" "bucket" to another')
def an_object_has_been_copied(lws_session):
    S3apiTestClient(lws_session).create_bucket()
    S3apiTestClient(lws_session).put_object(bucket=TEST_SRC_BUCKET, key=TEST_KEY)
    S3apiTestClient(lws_session).copy_object(
        Bucket=TEST_BUCKET, Key=TEST_KEY2, CopySource={"Bucket": TEST_SRC_BUCKET, "Key": TEST_KEY}
    )
