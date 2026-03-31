"""Given: the "secrets manager" "secret" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerTestClient


@given('the "secrets manager" "secret" already existed')
def secret_already_exists(lws_session):
    SecretsmanagerTestClient(lws_session).create_secret()
