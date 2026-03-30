"""When: a part is uploaded for a multipart upload"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_BODY, TEST_BUCKET, TEST_KEY


@when("a part is uploaded for a multipart upload")
def upload_part(lws_session, world):
    try:
        part_resp = lws_session.client("s3").upload_part(
            Bucket=TEST_BUCKET,
            Key=TEST_KEY,
            UploadId=world.get("upload_id", "invalid"),
            PartNumber=1,
            Body=TEST_BODY,
        )
        world["result"] = part_resp
        world.setdefault("etags", []).append({"ETag": part_resp["ETag"], "PartNumber": 1})
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
