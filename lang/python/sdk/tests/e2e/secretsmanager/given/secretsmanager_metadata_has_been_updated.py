"""Given: metadata or description for an active secret has been updated"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerTestClient
from ..constants import TEST_DESCRIPTION, TEST_SECRET


@given("metadata or description for an active secret has been updated")
def secretsmanager_metadata_has_been_updated(lws_session):
    try:
        SecretsmanagerTestClient(lws_session).create_secret()
    except Exception:
        pass
    SecretsmanagerTestClient(lws_session).update_secret(
        SecretId=TEST_SECRET, Description=TEST_DESCRIPTION
    )
