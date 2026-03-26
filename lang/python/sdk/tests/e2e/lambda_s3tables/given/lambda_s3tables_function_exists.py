"""Given: the function exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaS3tablesTestClient


@given("the function exists")
def lambda_s3tables_function_exists(lws_session):
    LambdaS3tablesTestClient(lws_session).create_function()
