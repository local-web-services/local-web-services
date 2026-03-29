"""Given: a secret has been created in Secrets Manager"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerLambdaTestClient


@given("a secret has been created in Secrets Manager")
def sm_lambda_a_secret_has_been_created_in_secrets_manager(lws_session):
    SecretsmanagerLambdaTestClient(lws_session).create_secret()
