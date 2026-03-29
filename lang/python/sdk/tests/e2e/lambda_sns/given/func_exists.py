"""Given: the function exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSnsTestClient


@given("the function exists")
def func_exists(lws_session):
    LambdaSnsTestClient(lws_session).create_function()
