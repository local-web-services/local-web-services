"""Given: a secret has been created in Secrets Manager"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSecretsmanagerTestClient


@given("a secret has been created in Secrets Manager")
def secret_has_been_created_seq(lws_session):
    LambdaSecretsmanagerTestClient(lws_session).create_secret()
