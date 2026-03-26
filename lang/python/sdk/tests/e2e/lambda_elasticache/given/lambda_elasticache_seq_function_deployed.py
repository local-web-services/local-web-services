"""Given: a Lambda function has been deployed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaElasticacheTestClient


@given("a Lambda function has been deployed")
def lambda_elasticache_seq_function_deployed(lws_session):
    LambdaElasticacheTestClient(lws_session).create_function()
