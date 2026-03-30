"""Given: the function already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaRdsTestClient


@given("the function already exists")
def func_already_exists(lws_session):
    LambdaRdsTestClient(lws_session).create_function()
