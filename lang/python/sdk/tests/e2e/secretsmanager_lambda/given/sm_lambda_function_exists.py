"""Given: the function exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerLambdaTestClient


@given("the function exists")
def sm_lambda_function_exists(lws_session):
    SecretsmanagerLambdaTestClient(lws_session).create_function()
