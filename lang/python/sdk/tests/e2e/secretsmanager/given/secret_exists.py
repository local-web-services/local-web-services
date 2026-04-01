"""Given: all secrets are listed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerTestClient


@given("all secrets are listed")
def secret_exists(lws_session):
    SecretsmanagerTestClient(lws_session).create_secret()
