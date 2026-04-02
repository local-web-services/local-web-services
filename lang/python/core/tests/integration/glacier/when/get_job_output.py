"""When: the output of a succeeded "glacier" "job" is retrieved"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_VAULT_NAME


@when('the output of a succeeded "glacier" "job" is retrieved')
def get_job_output(client: TestClient, world):
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    job_id = world.get("job_id", "nonexistent-job-id")
    r = client.get(f"/-/vaults/{vault_name}/jobs/{job_id}/output")
    if r.status_code == 200:
        try:
            world["result"] = r.json()
        except Exception:
            world["result"] = {"content": r.content}
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()
