"""Then: the "glacier" "vault" will exist with no "SNS" notification configuration"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_VAULT


@then('the "glacier" "vault" will exist with no "SNS" notification configuration')
def vault_exists_no_notification(lws_session):
    resp = lws_session.client("glacier").list_vaults(accountId="-")
    actual_vaults = [v["VaultName"] for v in resp.get("VaultList", [])]
    expected_vault = TEST_VAULT
    assert (
        expected_vault in actual_vaults
    ), f"Expected vault '{expected_vault}' to exist but not found in: {actual_vaults}"
