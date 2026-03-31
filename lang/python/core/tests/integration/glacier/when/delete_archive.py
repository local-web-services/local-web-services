"""When: a "glacier" "archive" is deleted from a "glacier" "vault" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_VAULT_NAME


@when('a "glacier" "archive" is deleted from a "glacier" "vault"')
def delete_archive(client: TestClient, world):
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    archive_id = world.get("archive_id", "nonexistent-archive-id")
    r = client.delete(f"/-/vaults/{vault_name}/archives/{archive_id}")
    if r.status_code == 204:
        world["result"] = {}
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()
