"""Given: the secret is "DELETED" """

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import SecretsmanagerTestClient


@given('the secret is "DELETED"')
def secret_is_deleted_given(sync_client: TestClient):
    SecretsmanagerTestClient(sync_client).delete_secret()
