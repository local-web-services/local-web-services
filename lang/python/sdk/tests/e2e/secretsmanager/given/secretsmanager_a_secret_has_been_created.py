"""Given: a secret has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerTestClient


@given("a secret has been created")
def secretsmanager_a_secret_has_been_created(lws_session):
    SecretsmanagerTestClient(lws_session).create_secret()
