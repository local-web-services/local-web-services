"""When: a multipart upload is completed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import S3apiTestClient
from ..constants import TEST_BUCKET, TEST_KEY


@when("a multipart upload is completed")
def complete_multipart_upload(lws_session, world):
    try:
        parts = world.get("etags") or [{"ETag": "etag1", "PartNumber": 1}]
        world["result"] = S3apiTestClient(lws_session).complete_multipart_upload(
            Bucket=TEST_BUCKET,
            Key=TEST_KEY,
            UploadId=world.get("upload_id", "invalid"),
            MultipartUpload={"Parts": parts},
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
