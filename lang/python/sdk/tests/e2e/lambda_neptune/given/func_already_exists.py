"""Given: the "lambda" "function" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaNeptuneTestClient


@given('the "lambda" "function" already existed')
def func_already_exists(lws_session):
    LambdaNeptuneTestClient(lws_session).create_function()
