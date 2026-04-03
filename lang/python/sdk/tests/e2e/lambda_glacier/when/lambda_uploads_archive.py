"""When: the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_VAULT


@when('the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds')
def lambda_uploads_archive(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id")
    if invocation_id is None:
        world["error"] = RuntimeError("No invocation is in progress")
        return
    try:
        lws_session.client("glacier").describe_vault(accountId="-", vaultName=TEST_VAULT)
    except ClientError:
        world["error"] = RuntimeError("Vault does not exist or is deleted")
        return
    if lws_session.capacity("glacier").is_exhausted():
        world["error"] = RuntimeError("No archive slot is available")
        return
    # Act
    lws_session.inject_state_unchecked("lambda", "invocation", invocation_id, "SUCCESS")
