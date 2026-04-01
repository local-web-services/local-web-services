"""Given: the "secretsmanager" "secret" already existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import SecretsmanagerTestClient


@given('the "secrets manager" "secret" already existed')
@given('the "secretsmanager" "secret" already existed')
def secret_already_exists(sync_client: TestClient):
    SecretsmanagerTestClient(sync_client).create_secret()
