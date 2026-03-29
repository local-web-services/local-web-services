"""Given: the function exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SnsLambdaTestClient


@given("the function exists")
def sns_lambda_function_exists(lws_session):
    SnsLambdaTestClient(lws_session).create_function()
