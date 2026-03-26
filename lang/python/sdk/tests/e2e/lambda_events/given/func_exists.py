"""Given: the function exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaEventsTestClient


@given("the function exists")
def func_exists(lws_session):
    LambdaEventsTestClient(lws_session).create_function()
