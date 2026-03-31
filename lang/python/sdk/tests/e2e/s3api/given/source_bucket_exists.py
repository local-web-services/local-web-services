"""Given: the source "s3" "bucket" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient
from ..constants import TEST_BUCKET, TEST_SRC_BUCKET


@given('the source "s3" "bucket" existed')
def source_bucket_exists(lws_session):
    S3apiTestClient(lws_session).create_bucket(name=TEST_SRC_BUCKET)
    S3apiTestClient(lws_session).create_bucket(name=TEST_BUCKET)
