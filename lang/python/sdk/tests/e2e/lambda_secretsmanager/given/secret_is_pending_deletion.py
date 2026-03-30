"""Given: the secret is "PENDING_DELETION" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSecretsmanagerTestClient
from ..constants import TEST_SECRET


@given('the secret is "PENDING_DELETION"')
def secret_is_pending_deletion(lws_session, world):
    try:
        LambdaSecretsmanagerTestClient(lws_session)._secretsmanager.delete_secret(
            SecretId=TEST_SECRET, ForceDeleteWithoutRecovery=True
        )
    except Exception:
        pass
    LambdaSecretsmanagerTestClient(lws_session).create_secret()
    LambdaSecretsmanagerTestClient(lws_session)._secretsmanager.delete_secret(
        SecretId=TEST_SECRET, RecoveryWindowInDays=7
    )
    world["result"] = None
    world["error"] = None
