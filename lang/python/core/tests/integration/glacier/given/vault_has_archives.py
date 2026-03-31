"""Given: the "glacier" "vault" had archives"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import GlacierTestClient
from ..constants import INT_VAULT_NAME


@given('the "glacier" "vault" had archives')
def vault_has_archives(client: TestClient, world):
    vault_name = world.get("vault_name", INT_VAULT_NAME)
    archive_id = GlacierTestClient(client).upload_archive(vault_name)
    world["archive_id"] = archive_id
