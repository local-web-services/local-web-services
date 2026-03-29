"""Given: the secret already exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import SecretsmanagerTestClient


@given("the secret already exists")
def secret_already_exists(sync_client: TestClient):
    SecretsmanagerTestClient(sync_client).create_secret()
