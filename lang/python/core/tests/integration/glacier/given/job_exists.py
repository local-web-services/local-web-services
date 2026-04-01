"""Given: the "glacier" "job" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import GlacierTestClient
from ..constants import INT_VAULT_NAME


@given('the "glacier" "job" existed')
def job_exists(client: TestClient, world):
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    if vault_name == "nonexistent-vault":
        world["job_id"] = "nonexistent-job-id"
        return
    GlacierTestClient(client).create_vault(vault_name)
    world["vault_name"] = vault_name
    job_id = GlacierTestClient(client).initiate_job(vault_name)
    world["job_id"] = job_id
