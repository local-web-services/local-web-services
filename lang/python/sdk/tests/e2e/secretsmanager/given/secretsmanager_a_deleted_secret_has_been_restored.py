"""Given: a deleted secret has been restored within the recovery window"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerTestClient
from ..constants import TEST_SECRET


@given("a deleted secret has been restored within the recovery window")
def secretsmanager_a_deleted_secret_has_been_restored(lws_session):
    try:
        SecretsmanagerTestClient(lws_session).create_secret()
    except Exception:
        pass
    SecretsmanagerTestClient(lws_session).delete_secret(SecretId=TEST_SECRET)
    SecretsmanagerTestClient(lws_session).restore_secret(SecretId=TEST_SECRET)
