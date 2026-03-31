"""Given: the "glacier" "vault" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import GlacierTestClient
from ..constants import INT_VAULT_NAME


@given('the "glacier" "vault" existed')
def vault_exists(client: TestClient, world):
    GlacierTestClient(client).create_vault()
    world["vault_name"] = INT_VAULT_NAME
