"""When: a vault inventory is refreshed"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_VAULT_NAME


@when("a vault inventory is refreshed")
def refresh_vault_inventory(client: TestClient, world):
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    r = client.post(
        f"/-/vaults/{vault_name}/jobs",
        json={"Type": "inventory-retrieval"},
    )
    if r.status_code == 202:
        world["result"] = {"JobId": r.headers.get("x-amz-job-id", "")}
        world["job_id"] = r.headers.get("x-amz-job-id", "")
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()
