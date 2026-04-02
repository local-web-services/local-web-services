"""Given: an "eventbridge" "bus" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsLambdaTestClient


@given('an "eventbridge" "bus" is created')
def events_lambda_seq_bus_created(lws_session):
    EventsLambdaTestClient(lws_session).create_bus()
