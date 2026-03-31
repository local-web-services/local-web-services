"""Then: the "secrets manager" "secret" will be "ACTIVE" with an initial version"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..client import SecretsmanagerTestClient
from ..constants import INT_SECRET


@then('the "secrets manager" "secret" will be "ACTIVE" with an initial version')
def secret_is_active_with_initial_version(sync_client: TestClient):
    desc = SecretsmanagerTestClient(sync_client).describe_secret()
    expected_name = INT_SECRET
    actual_name = desc.get("Name", "")
    assert (
        actual_name == expected_name
    ), f"Expected secret name '{expected_name}' but got '{actual_name}'"
    assert (
        "DeletedDate" not in desc
    ), f"Expected secret to be ACTIVE but got DeletedDate: {desc.get('DeletedDate')}"
