"""Given: the secrets manager secret existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import SecretsmanagerTestClient


@given('the "secrets manager" "secret" existed')
@given("the secrets manager secret existed")
def secret_exists(sync_client: TestClient):
    SecretsmanagerTestClient(sync_client).create_secret()
