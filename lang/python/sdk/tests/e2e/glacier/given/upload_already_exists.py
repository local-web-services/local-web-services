"""Given: the upload already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_PART_SIZE, TEST_VAULT


@given("the upload already exists")
def upload_already_exists(lws_session, world):
    vault_name = world.get("vault_name", TEST_VAULT)
    result = lws_session.client("glacier").initiate_multipart_upload(
        accountId="-",
        vaultName=vault_name,
        partSize=str(TEST_PART_SIZE),
    )
    world["upload_id"] = result.get("uploadId")
