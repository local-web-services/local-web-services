"""Given: a Lambda function has been deployed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaEventsTestClient


@given("a Lambda function has been deployed")
def lambda_events_seq_function_deployed(lws_session):
    LambdaEventsTestClient(lws_session).create_function()
