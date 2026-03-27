"""When: a part is uploaded for a multipart upload"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_VAULT


@when("a part is uploaded for a multipart upload")
def upload_multipart_part(lws_session, world):
    try:
        upload_id = world.get("upload_id", "")
        part_body = b"e2e-test-part-data"
        result = lws_session.client("glacier").upload_multipart_part(
            accountId="-",
            vaultName=world.get("vault_name", TEST_VAULT),
            uploadId=upload_id,
            range="bytes 0-17/*",
            body=part_body,
        )
        world["result"] = result
        world["part_uploaded"] = True
        world["error"] = None
    except ClientError as exc:
        world["result"] = None
        world["error"] = exc
