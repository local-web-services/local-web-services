"""Given: sname in secret_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerTestClient


@given("sname in secret_status")
def secretsmanager_sname_in_secret_status(lws_session):
    SecretsmanagerTestClient(lws_session).create_secret()
