"""When: a multipart "s3" "upload" is initiated"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_BUCKET, TEST_KEY


@when('a multipart "s3" "upload" is initiated')
def create_multipart_upload(lws_session, world):
    try:
        resp = lws_session.client("s3").create_multipart_upload(Bucket=TEST_BUCKET, Key=TEST_KEY)
        world["result"] = resp
        world["upload_id"] = resp.get("UploadId")
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
