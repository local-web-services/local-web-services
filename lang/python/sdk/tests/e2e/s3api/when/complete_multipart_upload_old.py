"""When: a multipart "s3" "upload" is completed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_BUCKET, TEST_KEY


@when('a multipart "s3" "upload" is completed')
def complete_multipart_upload_old(lws_session, world):
    try:
        world["result"] = lws_session.client("s3").complete_multipart_upload(
            Bucket=TEST_BUCKET,
            Key=TEST_KEY,
            UploadId=world.get("upload_id", "invalid"),
            MultipartUpload={"Parts": [{"ETag": "etag1", "PartNumber": 1}]},
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
