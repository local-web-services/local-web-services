"""Given: the "glacier" "upload" was not "InProgress" """

from __future__ import annotations

from pytest_bdd import given

from ..constants import TEST_VAULT


@given('the "glacier" "upload" was not "InProgress"')
def upload_is_not_in_progress_given(lws_session, world):
    upload_id = world.get("upload_id") or "nonexistent-upload-id"
    vault_name = world.get("vault_name", TEST_VAULT)
    lws_session.client("glacier").abort_multipart_upload(
        accountId="-",
        vaultName=vault_name,
        uploadId=upload_id,
    )
