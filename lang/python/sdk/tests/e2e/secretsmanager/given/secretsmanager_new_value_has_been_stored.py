"""Given: a new value has been stored for an active secret"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerTestClient
from ..constants import TEST_SECRET, TEST_VALUE2


@given("a new value has been stored for an active secret")
def secretsmanager_new_value_has_been_stored(lws_session):
    try:
        SecretsmanagerTestClient(lws_session).create_secret()
    except Exception:
        pass
    SecretsmanagerTestClient(lws_session).put_secret_value(
        SecretId=TEST_SECRET, SecretString=TEST_VALUE2
    )
