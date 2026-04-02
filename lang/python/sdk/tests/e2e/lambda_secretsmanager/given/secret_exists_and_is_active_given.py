"""Given: the "secrets manager" "secret" existed and was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSecretsmanagerTestClient


@given('the "secrets manager" "secret" existed and was "ACTIVE"')
def secret_exists_and_is_active_given(lws_session):
    LambdaSecretsmanagerTestClient(lws_session).create_secret()
