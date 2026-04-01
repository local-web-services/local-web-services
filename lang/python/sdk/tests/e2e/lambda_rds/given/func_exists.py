"""Given: the "lambda" "function" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaRdsTestClient


@given('the "lambda" "function" existed')
def func_exists(lws_session):
    LambdaRdsTestClient(lws_session).create_function()
