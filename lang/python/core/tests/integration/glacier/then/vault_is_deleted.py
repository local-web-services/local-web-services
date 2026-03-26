"""Then: the vault is "DELETED" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import INT_VAULT_NAME


@then('the vault is "DELETED"')
def vault_is_deleted(client: TestClient, world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected vault deletion to succeed but got: {actual_error}"
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    r = client.get(f"/-/vaults/{vault_name}")
    expected_status_code = 404
    actual_status_code = r.status_code
    assert (
        actual_status_code == expected_status_code
    ), f"Expected vault to be deleted (404) but got status {actual_status_code}"
