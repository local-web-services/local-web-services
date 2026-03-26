"""Given: the function already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSsmTestClient


@given("the function already exists")
def func_already_exists(lws_session):
    LambdaSsmTestClient(lws_session).create_function()
