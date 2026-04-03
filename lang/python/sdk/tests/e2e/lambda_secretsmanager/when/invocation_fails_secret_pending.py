"""When: the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_SECRET


@when('the "lambda" "function" fails because the "secretsmanager" "secret" is pending deletion')
def invocation_fails_secret_pending(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id")
    if invocation_id is None:
        world["error"] = RuntimeError("No invocation is in progress")
        return
    try:
        resp = lws_session.client("secretsmanager").describe_secret(SecretId=TEST_SECRET)
        if not resp.get("DeletedDate"):
            world["error"] = RuntimeError("Secret is not pending deletion")
            return
    except ClientError:
        world["error"] = RuntimeError("Secret does not exist")
        return
    # Act
    lws_session.inject_state_unchecked("lambda", "invocation", invocation_id, "FAILED")
