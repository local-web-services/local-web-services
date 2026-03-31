"""Given: the "secretsmanager" "secret" is not pending deletion"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSecretsmanagerTestClient


@given('the "secretsmanager" "secret" is not pending deletion')
def secret_is_not_pending_deletion(lws_session):
    LambdaSecretsmanagerTestClient(lws_session).create_secret()
