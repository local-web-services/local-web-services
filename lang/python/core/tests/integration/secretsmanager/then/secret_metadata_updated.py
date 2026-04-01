"""Then: the "secrets manager" "secret" metadata will be updated"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..client import SecretsmanagerTestClient
from ..constants import INT_DESCRIPTION


@then('the "secrets manager" "secret" metadata will be updated')
def secret_metadata_updated(sync_client: TestClient):
    desc = SecretsmanagerTestClient(sync_client).describe_secret()
    expected_description = INT_DESCRIPTION
    actual_description = desc.get("Description", "")
    assert (
        actual_description == expected_description
    ), f"Expected description '{expected_description}' but got '{actual_description}'"
