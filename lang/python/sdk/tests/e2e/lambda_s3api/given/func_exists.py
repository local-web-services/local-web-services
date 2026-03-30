"""Given: the function exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaS3apiTestClient


@given("the function exists")
def func_exists(lws_session):
    LambdaS3apiTestClient(lws_session).create_function()
