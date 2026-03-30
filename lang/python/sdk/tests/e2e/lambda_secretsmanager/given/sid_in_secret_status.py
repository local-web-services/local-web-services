"""Given: sid in secret_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSecretsmanagerTestClient


@given("sid in secret_status")
def sid_in_secret_status(lws_session):
    LambdaSecretsmanagerTestClient(lws_session).create_secret()
