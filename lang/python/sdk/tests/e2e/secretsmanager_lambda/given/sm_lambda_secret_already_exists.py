"""Given: the "secretsmanager" "secret" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerLambdaTestClient


@given('the "secretsmanager" "secret" already existed')
def sm_lambda_secret_already_exists(lws_session):
    SecretsmanagerLambdaTestClient(lws_session).create_secret()
