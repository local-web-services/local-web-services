"""Given: the secret is not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSecretsmanagerTestClient
from ..constants import TEST_SECRET


@given('the secret is not "ACTIVE"')
def secret_is_not_active_given(lws_session, world):
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
