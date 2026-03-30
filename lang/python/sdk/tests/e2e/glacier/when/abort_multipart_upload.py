"""When: a multipart upload is aborted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_VAULT


@when("a multipart upload is aborted")
def abort_multipart_upload(lws_session, world):
    try:
        upload_id = world.get("upload_id") or "nonexistent-upload-id"
        result = lws_session.client("glacier").abort_multipart_upload(
            accountId="-",
            vaultName=world.get("vault_name", TEST_VAULT),
            uploadId=upload_id,
        )
        world["result"] = result
        world["error"] = None
    except ClientError as exc:
        world["result"] = None
        world["error"] = exc
