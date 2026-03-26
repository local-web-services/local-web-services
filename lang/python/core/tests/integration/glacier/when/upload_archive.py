"""When: an archive is uploaded to a vault"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_ARCHIVE_BODY, INT_VAULT_NAME


@when("an archive is uploaded to a vault")
def upload_archive(client: TestClient, world):
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    r = client.post(
        f"/-/vaults/{vault_name}/archives",
        content=INT_ARCHIVE_BODY,
    )
    if r.status_code == 201:
        world["result"] = {"ArchiveId": r.headers.get("x-amz-archive-id", "")}
        world["archive_id"] = r.headers.get("x-amz-archive-id", "")
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()
