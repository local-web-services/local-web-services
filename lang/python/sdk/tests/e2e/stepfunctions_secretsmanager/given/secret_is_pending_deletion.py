"""Given: the "secretsmanager" "secret" was "PENDING_DELETION" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSecretsmanagerTestClient
from ..constants import TEST_SECRET


@given('the "secretsmanager" "secret" was "PENDING_DELETION"')
def secret_is_pending_deletion(lws_session):
    StepfunctionsSecretsmanagerTestClient(lws_session).create_secret()
    StepfunctionsSecretsmanagerTestClient(lws_session)._sm_client.delete_secret(
        SecretId=TEST_SECRET
    )
