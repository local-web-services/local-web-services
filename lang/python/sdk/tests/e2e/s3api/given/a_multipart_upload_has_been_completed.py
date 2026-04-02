"""Given: a multipart "s3" "upload" is completed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient
from ..constants import TEST_BODY, TEST_BUCKET, TEST_KEY


@given('a multipart "s3" "upload" is completed')
def a_multipart_upload_has_been_completed(lws_session):
    S3apiTestClient(lws_session).create_bucket()
    resp = S3apiTestClient(lws_session).create_multipart_upload(Bucket=TEST_BUCKET, Key=TEST_KEY)
    upload_id = resp["UploadId"]
    part_resp = S3apiTestClient(lws_session).upload_part(
        Bucket=TEST_BUCKET,
        Key=TEST_KEY,
        UploadId=upload_id,
        PartNumber=1,
        Body=TEST_BODY,
    )
    S3apiTestClient(lws_session).complete_multipart_upload(
        Bucket=TEST_BUCKET,
        Key=TEST_KEY,
        UploadId=upload_id,
        MultipartUpload={"Parts": [{"ETag": part_resp["ETag"], "PartNumber": 1}]},
    )
