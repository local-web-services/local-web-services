"""Given: the "secrets manager" "secret" existed and was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerLambdaTestClient


@given('the "secrets manager" "secret" existed and was "ACTIVE"')
def sm_lambda_secret_exists_and_active(lws_session):
    SecretsmanagerLambdaTestClient(lws_session).create_secret()
