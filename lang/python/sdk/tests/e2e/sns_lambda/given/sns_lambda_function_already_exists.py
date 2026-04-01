"""Given: the "lambda" "function" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsLambdaTestClient


@given('the "lambda" "function" already existed')
def sns_lambda_function_already_exists(lws_session):
    SnsLambdaTestClient(lws_session).create_function()
