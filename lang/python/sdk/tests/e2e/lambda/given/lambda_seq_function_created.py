"""Given: a function has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaTestClient


@given("a function has been created")
def lambda_seq_function_created(lws_session):
    LambdaTestClient(lws_session).create_function()
