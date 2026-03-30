"""Given: a secret has been scheduled for deletion"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSecretsmanagerTestClient
from ..constants import TEST_SECRET


@given("a secret has been scheduled for deletion")
def secret_has_been_scheduled_for_deletion_seq(lws_session):
    try:
        LambdaSecretsmanagerTestClient(lws_session).create_secret()
    except Exception:
        pass
    LambdaSecretsmanagerTestClient(lws_session)._secretsmanager.delete_secret(
        SecretId=TEST_SECRET, RecoveryWindowInDays=7
    )
