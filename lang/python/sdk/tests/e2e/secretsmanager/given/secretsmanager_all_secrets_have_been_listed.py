"""Given: all "secrets manager" "secret"s are listed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerTestClient


@given('all "secrets manager" "secret"s are listed')
def secretsmanager_all_secrets_have_been_listed(lws_session):
    try:
        SecretsmanagerTestClient(lws_session).create_secret()
    except Exception:
        pass
    SecretsmanagerTestClient(lws_session).list_secrets()
