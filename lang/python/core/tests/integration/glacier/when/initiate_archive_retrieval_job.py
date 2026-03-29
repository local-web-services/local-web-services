"""When: an archive retrieval job is initiated"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_VAULT_NAME


@when("an archive retrieval job is initiated")
def initiate_archive_retrieval_job(client: TestClient, world):
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    archive_id = world.get("archive_id", "nonexistent-archive-id")
    r = client.post(
        f"/-/vaults/{vault_name}/jobs",
        json={"Type": "archive-retrieval", "ArchiveId": archive_id},
    )
    if r.status_code == 202:
        world["result"] = {"JobId": r.headers.get("x-amz-job-id", "")}
        world["job_id"] = r.headers.get("x-amz-job-id", "")
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()
