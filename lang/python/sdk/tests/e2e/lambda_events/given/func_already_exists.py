"""Given: the "lambda" "function" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaEventsTestClient


@given('the "lambda" "function" already existed')
def func_already_exists(lws_session):
    LambdaEventsTestClient(lws_session).create_function()
