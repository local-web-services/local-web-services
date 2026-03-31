"""Given: the "secrets manager" "secret" was "DELETED" """

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import SecretsmanagerTestClient


@given('the "secrets manager" "secret" was "DELETED"')
def secret_is_deleted_given(sync_client: TestClient):
    SecretsmanagerTestClient(sync_client).delete_secret()
