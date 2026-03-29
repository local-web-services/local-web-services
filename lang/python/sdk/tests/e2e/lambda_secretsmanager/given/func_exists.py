"""Given: the function exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSecretsmanagerTestClient


@given("the function exists")
def func_exists(lws_session):
    LambdaSecretsmanagerTestClient(lws_session).create_function()
