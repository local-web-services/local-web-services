"""When: an empty vault is deleted"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_VAULT_NAME


@when("an empty vault is deleted")
def delete_vault(client: TestClient, world):
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    r = client.delete(f"/-/vaults/{vault_name}")
    if r.status_code == 204:
        world["result"] = {}
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()
