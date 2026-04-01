"""Given: reserved concurrency is set for a "lambda" "function" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaTestClient


@given('reserved concurrency is set for a "lambda" "function"')
def lambda_seq_concurrency_set(lws_session):
    LambdaTestClient(lws_session).create_function()
