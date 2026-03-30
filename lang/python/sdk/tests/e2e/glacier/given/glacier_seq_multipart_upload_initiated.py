"""Given: a multipart upload has been initiated for a vault"""

from __future__ import annotations

from pytest_bdd import given

from ..client import GlacierTestClient
from ..constants import TEST_PART_SIZE, TEST_VAULT


@given("a multipart upload has been initiated for a vault")
def glacier_seq_multipart_upload_initiated(lws_session, world):
    vault_name = world.get("vault_name", TEST_VAULT)
    GlacierTestClient(lws_session).create_vault(vault_name=vault_name)
    result = lws_session.client("glacier").initiate_multipart_upload(
        accountId="-",
        vaultName=vault_name,
        partSize=str(TEST_PART_SIZE),
    )
    world["upload_id"] = result.get("uploadId")
