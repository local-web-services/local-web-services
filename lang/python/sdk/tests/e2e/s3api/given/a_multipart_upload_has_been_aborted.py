"""Given: a multipart "s3" "upload" is aborted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient
from ..constants import TEST_BUCKET, TEST_KEY


@given('a multipart "s3" "upload" is aborted')
def a_multipart_upload_has_been_aborted(lws_session):
    S3apiTestClient(lws_session).create_bucket()
    resp = S3apiTestClient(lws_session).create_multipart_upload(Bucket=TEST_BUCKET, Key=TEST_KEY)
    S3apiTestClient(lws_session).abort_multipart_upload(
        Bucket=TEST_BUCKET, Key=TEST_KEY, UploadId=resp["UploadId"]
    )
