"""Given: the "lambda" "function" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsLambdaTestClient


@given('the "lambda" "function" already existed')
def events_lambda_function_already_exists(lws_session):
    EventsLambdaTestClient(lws_session).create_function()
