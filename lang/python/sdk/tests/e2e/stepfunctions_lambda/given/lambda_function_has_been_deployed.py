"""Given: a Lambda function has been deployed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsLambdaTestClient


@given("a Lambda function has been deployed")
def lambda_function_has_been_deployed(lws_session):
    StepfunctionsLambdaTestClient(lws_session).create_function()
