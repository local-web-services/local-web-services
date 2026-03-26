"""Given: a multipart upload has been initiated"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient
from ..constants import TEST_BUCKET, TEST_KEY


@given("a multipart upload has been initiated")
def a_multipart_upload_has_been_initiated(lws_session):
    S3apiTestClient(lws_session).create_bucket()
    S3apiTestClient(lws_session).create_multipart_upload(Bucket=TEST_BUCKET, Key=TEST_KEY)
