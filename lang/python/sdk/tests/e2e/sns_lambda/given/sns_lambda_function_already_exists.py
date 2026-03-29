"""Given: the function already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsLambdaTestClient


@given("the function already exists")
def sns_lambda_function_already_exists(lws_session):
    SnsLambdaTestClient(lws_session).create_function()
