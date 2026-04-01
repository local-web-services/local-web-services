"""Given: the "secrets manager" "secret" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerTestClient


@given('the "secrets manager" "secret" existed')
def secretsmanager_a_secret_has_been_created(lws_session):
    SecretsmanagerTestClient(lws_session).create_secret()
