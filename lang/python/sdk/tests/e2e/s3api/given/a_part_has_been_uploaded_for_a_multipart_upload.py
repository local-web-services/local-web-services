"""Given: a part is uploaded for a multipart "s3" "upload" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient
from ..constants import TEST_BODY, TEST_BUCKET, TEST_KEY


@given('a part is uploaded for a multipart "s3" "upload"')
def a_part_has_been_uploaded_for_a_multipart_upload(lws_session):
    S3apiTestClient(lws_session).create_bucket()
    resp = S3apiTestClient(lws_session).create_multipart_upload(Bucket=TEST_BUCKET, Key=TEST_KEY)
    S3apiTestClient(lws_session).upload_part(
        Bucket=TEST_BUCKET,
        Key=TEST_KEY,
        UploadId=resp["UploadId"],
        PartNumber=1,
        Body=TEST_BODY,
    )
