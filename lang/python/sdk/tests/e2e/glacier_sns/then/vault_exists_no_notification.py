"""Then: the vault "EXISTS" with no "SNS" notification configuration"""

from __future__ import annotations

from pytest_bdd import then

from ..client import GlacierSnsTestClient
from ..constants import TEST_VAULT


@then('the vault "EXISTS" with no "SNS" notification configuration')
def vault_exists_no_notification(lws_session):
    resp = GlacierSnsTestClient(lws_session)._glacier.list_vaults(accountId="-")
    actual_vaults = [v["VaultName"] for v in resp.get("VaultList", [])]
    expected_vault = TEST_VAULT
    assert (
        expected_vault in actual_vaults
    ), f"Expected vault '{expected_vault}' to exist but not found in: {actual_vaults}"
