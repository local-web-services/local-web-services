"""Given: the upload is "IN_PROGRESS" with at least one part uploaded"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient
from ..constants import TEST_BODY, TEST_BUCKET, TEST_KEY


@given('the upload is "IN_PROGRESS" with at least one part uploaded')
def upload_in_progress_with_part(lws_session, world):
    resp = S3apiTestClient(lws_session).create_multipart_upload(Bucket=TEST_BUCKET, Key=TEST_KEY)
    world["upload_id"] = resp["UploadId"]
    part_resp = S3apiTestClient(lws_session).upload_part(
        Bucket=TEST_BUCKET, Key=TEST_KEY, UploadId=world["upload_id"], PartNumber=1, Body=TEST_BODY
    )
    world["etags"] = [{"ETag": part_resp["ETag"], "PartNumber": 1}]
