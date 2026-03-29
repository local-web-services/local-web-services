"""Given: a secret has been deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerTestClient
from ..constants import TEST_SECRET


@given("a secret has been deleted")
def secretsmanager_a_secret_has_been_deleted(lws_session):
    try:
        SecretsmanagerTestClient(lws_session).create_secret()
    except Exception:
        pass
    SecretsmanagerTestClient(lws_session).delete_secret(SecretId=TEST_SECRET)
