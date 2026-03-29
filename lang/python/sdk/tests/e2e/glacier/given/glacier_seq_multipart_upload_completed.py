"""Given: a multipart upload has been completed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import GlacierTestClient
from ..constants import TEST_PART_SIZE, TEST_VAULT

_PART_BODY = b"e2e-test-part-data"


@given("a multipart upload has been completed")
def glacier_seq_multipart_upload_completed(lws_session, world):
    vault_name = world.get("vault_name", TEST_VAULT)
    GlacierTestClient(lws_session).create_vault(vault_name=vault_name)
    upload_id = world.get("upload_id")
    if not upload_id:
        result = lws_session.client("glacier").initiate_multipart_upload(
            accountId="-",
            vaultName=vault_name,
            partSize=str(TEST_PART_SIZE),
        )
        upload_id = result.get("uploadId")
        world["upload_id"] = upload_id
    if not world.get("part_uploaded"):
        lws_session.client("glacier").upload_multipart_part(
            accountId="-",
            vaultName=vault_name,
            uploadId=upload_id,
            range="bytes 0-17/*",
            body=_PART_BODY,
        )
    complete_result = lws_session.client("glacier").complete_multipart_upload(
        accountId="-",
        vaultName=vault_name,
        uploadId=upload_id,
        archiveSize=str(len(_PART_BODY)),
        checksum="0" * 64,
    )
    world["archive_id"] = complete_result.get("archiveId")
