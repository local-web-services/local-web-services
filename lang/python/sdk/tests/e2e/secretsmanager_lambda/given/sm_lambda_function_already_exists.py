"""Given: the "lambda" "function" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerLambdaTestClient


@given('the "lambda" "function" already existed')
def sm_lambda_function_already_exists(lws_session):
    SecretsmanagerLambdaTestClient(lws_session).create_function()
