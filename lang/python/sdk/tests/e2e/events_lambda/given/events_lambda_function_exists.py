"""Given: the function exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsLambdaTestClient


@given("the function exists")
def events_lambda_function_exists(lws_session):
    EventsLambdaTestClient(lws_session).create_function()
