"""Given: the function already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaSecretsmanagerTestClient


@given("the function already exists")
def func_already_exists(lws_session):
    LambdaSecretsmanagerTestClient(lws_session).create_function()
