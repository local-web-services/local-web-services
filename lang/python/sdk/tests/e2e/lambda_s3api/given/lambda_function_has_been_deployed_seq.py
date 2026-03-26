"""Given: a Lambda function has been deployed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaS3apiTestClient


@given("a Lambda function has been deployed")
def lambda_function_has_been_deployed_seq(lws_session):
    LambdaS3apiTestClient(lws_session).create_function()
