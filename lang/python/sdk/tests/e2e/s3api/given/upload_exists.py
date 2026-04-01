"""Given: the "s3" "upload" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient
from ..constants import TEST_BUCKET, TEST_KEY


@given('the "s3" "upload" existed')
def upload_exists(lws_session, world):
    resp = S3apiTestClient(lws_session).create_multipart_upload(Bucket=TEST_BUCKET, Key=TEST_KEY)
    world["upload_id"] = resp["UploadId"]
    world["etags"] = []
