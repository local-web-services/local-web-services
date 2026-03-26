"""Given: a Lambda function has been deployed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsLambdaTestClient


@given("a Lambda function has been deployed")
def events_lambda_seq_function_deployed(lws_session):
    EventsLambdaTestClient(lws_session).create_function()
