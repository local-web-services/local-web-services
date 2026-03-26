"""Given: the function exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSqsProducerTestClient


@given("the function exists")
def func_exists(lws_session):
    LambdaSqsProducerTestClient(lws_session).create_function()
