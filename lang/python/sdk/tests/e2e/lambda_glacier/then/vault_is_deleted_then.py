"""Then: the "glacier" "vault" will be deleted and archive uploads will fail"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import then

from ..constants import TEST_VAULT


@then('the "glacier" "vault" will be deleted and archive uploads will fail')
def vault_is_deleted_then(lws_session):
    try:
        lws_session.client("glacier").describe_vault(accountId="-", vaultName=TEST_VAULT)
        raise AssertionError(f"Expected vault '{TEST_VAULT}' to be deleted but it still exists")
    except ClientError as exc:
        error_code = exc.response["Error"]["Code"]
        expected_code = "ResourceNotFoundException"
        assert error_code == expected_code, f"Expected '{expected_code}' but got: {error_code}"
