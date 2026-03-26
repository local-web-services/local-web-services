"""Then: the vault "EXISTS" """

from __future__ import annotations

from pytest_bdd import then

from ..client import LambdaGlacierTestClient
from ..constants import TEST_VAULT


@then('the vault "EXISTS"')
def vault_exists_then(lws_session):
    resp = LambdaGlacierTestClient(lws_session)._glacier.describe_vault(
        accountId="-", vaultName=TEST_VAULT
    )
    actual_name = resp.get("VaultName", "")
    expected_name = TEST_VAULT
    assert (
        actual_name == expected_name
    ), f"Expected vault name '{expected_name}' but got '{actual_name}'"
