"""Given: the current value of an active "secrets manager" "secret" is retrieved"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerTestClient
from ..constants import TEST_SECRET


@given('the current value of an active "secrets manager" "secret" is retrieved')
def secretsmanager_current_value_has_been_retrieved(lws_session):
    try:
        SecretsmanagerTestClient(lws_session).create_secret()
    except Exception:
        pass
    SecretsmanagerTestClient(lws_session).get_secret_value(SecretId=TEST_SECRET)
