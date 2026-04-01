"""Given: a "lambda" "rotation function" is deployed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SecretsmanagerLambdaTestClient


@given('a "lambda" "rotation function" is deployed')
def sm_lambda_a_lambda_rotation_function_has_been_deployed(lws_session):
    SecretsmanagerLambdaTestClient(lws_session).create_function()
