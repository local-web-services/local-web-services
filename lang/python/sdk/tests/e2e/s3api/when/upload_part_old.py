"""When: a part is uploaded for a multipart "s3" "upload" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_BODY, TEST_BUCKET, TEST_KEY


@when('a part is uploaded for a multipart "s3" "upload"')
def upload_part_old(lws_session, world):
    try:
        world["result"] = lws_session.client("s3").upload_part(
            Bucket=TEST_BUCKET,
            Key=TEST_KEY,
            UploadId=world.get("upload_id", "invalid"),
            PartNumber=1,
            Body=TEST_BODY,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
