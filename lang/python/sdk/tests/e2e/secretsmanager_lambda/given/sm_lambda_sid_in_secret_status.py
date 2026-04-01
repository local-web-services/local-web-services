"""Given: sid in secret_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerLambdaTestClient


@given("sid in secret_status")
def sm_lambda_sid_in_secret_status(lws_session):
    SecretsmanagerLambdaTestClient(lws_session).create_secret()
