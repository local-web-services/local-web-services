"""Then: the archive is "STORED" and the vault archive count increases"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import INT_VAULT_NAME


@then('the archive is "STORED" and the vault archive count increases')
def archive_is_stored_count_increases(client: TestClient, world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected archive upload to succeed but got: {actual_error}"
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    r = client.get(f"/-/vaults/{vault_name}")
    body = r.json()
    actual_archive_count = body.get("NumberOfArchives", 0)
    assert (
        actual_archive_count >= 1
    ), f"Expected at least 1 archive in vault but got {actual_archive_count}"
