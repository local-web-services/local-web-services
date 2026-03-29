"""Given: a function's configuration has been updated"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaTestClient


@given("a function's configuration has been updated")
def lambda_seq_function_config_updated(lws_session):
    LambdaTestClient(lws_session).create_function()
