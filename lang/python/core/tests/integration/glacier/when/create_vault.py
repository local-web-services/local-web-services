"""When: a "glacier" "vault" is created"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_VAULT_NAME


@when('a "glacier" "vault" is created')
def create_vault(client: TestClient, world):
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    r = client.put(f"/-/vaults/{vault_name}")
    if r.status_code == 201:
        world["result"] = {"Location": r.headers.get("location", "")}
        world["vault_name"] = vault_name
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()
