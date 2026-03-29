"""Given: reserved concurrency has been set for a function"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaTestClient


@given("reserved concurrency has been set for a function")
def lambda_seq_concurrency_set(lws_session):
    LambdaTestClient(lws_session).create_function()
