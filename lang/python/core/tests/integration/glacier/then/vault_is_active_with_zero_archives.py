"""Then: the "glacier" "vault" will be "ACTIVE" with zero archives"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import INT_VAULT_NAME


@then('the "glacier" "vault" will be "ACTIVE" with zero archives')
def vault_is_active_with_zero_archives(client: TestClient, world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected vault creation to succeed but got: {actual_error}"
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    r = client.get(f"/-/vaults/{vault_name}")
    body = r.json()
    expected_archive_count = 0
    actual_archive_count = body.get("NumberOfArchives", -1)
    assert (
        actual_archive_count == expected_archive_count
    ), f"Expected {expected_archive_count} archives but got {actual_archive_count}"
