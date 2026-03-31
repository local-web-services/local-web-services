"""Given: a "lambda" "function" is deployed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSqsTestClient


@given('a "lambda" "function" is deployed')
def lambda_function_has_been_deployed_seq(lws_session):
    LambdaSqsTestClient(lws_session).create_function()
