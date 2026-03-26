"""Given: the function already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSqsTestClient


@given("the function already exists")
def func_already_exists(lws_session):
    LambdaSqsTestClient(lws_session).create_function()
