"""Given: the "secrets manager" "secret" was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerTestClient
from ..constants import TEST_SECRET


@given('the "secrets manager" "secret" was not "ACTIVE"')
def secret_is_not_active_given(lws_session, world):
    """Put the secret in CREATING state (not ACTIVE) via lifecycle simulation."""
    lws_session.lifecycle("secretsmanager").create_dwell_ms(5000).apply()
    try:
        SecretsmanagerTestClient(lws_session).delete_secret(
            SecretId=TEST_SECRET, ForceDeleteWithoutRecovery=True
        )
    except Exception:
        pass
    SecretsmanagerTestClient(lws_session).create_secret()
