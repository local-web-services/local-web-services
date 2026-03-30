"""Given: the archive exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import GlacierTestClient
from ..constants import INT_VAULT_NAME


@given("the archive exists")
def archive_exists(client: TestClient, world):
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    archive_id = GlacierTestClient(client).upload_archive(vault_name)
    world["archive_id"] = archive_id
