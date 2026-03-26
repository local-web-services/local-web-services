"""Then: the archive is "DELETED" and the vault archive count decreases"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import INT_VAULT_NAME


@then('the archive is "DELETED" and the vault archive count decreases')
def archive_is_deleted_count_decreases(client: TestClient, world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected archive deletion to succeed but got: {actual_error}"
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    r = client.get(f"/-/vaults/{vault_name}")
    body = r.json()
    expected_archive_count = 0
    actual_archive_count = body.get("NumberOfArchives", -1)
    assert actual_archive_count == expected_archive_count, (
        f"Expected {expected_archive_count} archives after deletion but got "
        f"{actual_archive_count}"
    )
