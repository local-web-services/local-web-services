"""Then: the secret is "ACTIVE" again and the recovery window is closed"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..client import SecretsmanagerTestClient


@then('the secret is "ACTIVE" again and the recovery window is closed')
def secret_is_active_again(sync_client: TestClient):
    desc = SecretsmanagerTestClient(sync_client).describe_secret()
    assert (
        "DeletedDate" not in desc
    ), f"Expected secret to be ACTIVE (no DeletedDate) but got: {desc.get('DeletedDate')}"
