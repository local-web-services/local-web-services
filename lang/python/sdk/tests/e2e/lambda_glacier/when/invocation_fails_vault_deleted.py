"""When: the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_VAULT


@when('the "lambda" "function" fails to upload because the "glacier" "vault" has been deleted')
def invocation_fails_vault_deleted(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id")
    if invocation_id is None:
        world["error"] = RuntimeError("No invocation is in progress")
        return
    try:
        lws_session.client("glacier").describe_vault(accountId="-", vaultName=TEST_VAULT)
        world["error"] = RuntimeError("Vault is not deleted")
        return
    except ClientError:
        pass
    # Act
    lws_session.inject_state_unchecked("lambda", "invocation", invocation_id, "FAILED")
