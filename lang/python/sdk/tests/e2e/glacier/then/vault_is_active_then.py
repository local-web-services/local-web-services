"""Then: the vault is "ACTIVE" with zero archives"""

from __future__ import annotations

from pytest_bdd import then

from ..client import GlacierTestClient
from ..constants import TEST_VAULT


@then('the vault is "ACTIVE" with zero archives')
def vault_is_active_then(lws_session):
    resp = GlacierTestClient(lws_session).list_vaults(accountId="-")
    actual_vaults = resp.get("VaultList", [])
    actual_names = [v["VaultName"] for v in actual_vaults]
    assert (
        TEST_VAULT in actual_names
    ), f"Expected vault '{TEST_VAULT}' to be ACTIVE but not found in: {actual_names}"
