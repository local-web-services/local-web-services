"""Given: the function already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaTestClient


@given("the function already exists")
def function_already_exists(lws_session):
    LambdaTestClient(lws_session).create_function()
