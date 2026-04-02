"""Given: the "s3" "upload" has at least one part"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient
from ..constants import TEST_BODY, TEST_BUCKET, TEST_KEY


@given('the "s3" "upload" had at least one part')
def upload_has_at_least_one_part(lws_session, world):
    part_resp = S3apiTestClient(lws_session).upload_part(
        Bucket=TEST_BUCKET,
        Key=TEST_KEY,
        UploadId=world["upload_id"],
        PartNumber=1,
        Body=TEST_BODY,
    )
    world.setdefault("etags", []).append({"ETag": part_resp["ETag"], "PartNumber": 1})
