"""When: a multipart upload is completed"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_VAULT


@when("a multipart upload is completed")
def complete_multipart_upload(lws_session, world):
    try:
        upload_id = world.get("upload_id") or "nonexistent-upload-id"
        result = lws_session.client("glacier").complete_multipart_upload(
            accountId="-",
            vaultName=world.get("vault_name", TEST_VAULT),
            uploadId=upload_id,
            archiveSize=str(world.get("part_size", 18)),
            checksum="0" * 64,
        )
        world["result"] = result
        world["archive_id"] = result.get("archiveId")
        world["error"] = None
    except ClientError as exc:
        world["result"] = None
        world["error"] = exc
