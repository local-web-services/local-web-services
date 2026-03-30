"""Given: the function already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerLambdaTestClient


@given("the function already exists")
def sm_lambda_function_already_exists(lws_session):
    SecretsmanagerLambdaTestClient(lws_session).create_function()
