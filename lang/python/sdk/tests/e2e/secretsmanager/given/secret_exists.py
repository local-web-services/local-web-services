"""Given: all "secrets manager" "secret"s are listed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerTestClient


@given('all "secrets manager" "secret"s are listed')
def secret_exists(lws_session):
    SecretsmanagerTestClient(lws_session).create_secret()
