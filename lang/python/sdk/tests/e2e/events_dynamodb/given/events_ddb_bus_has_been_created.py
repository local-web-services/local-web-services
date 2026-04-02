"""Given: an "eventbridge" "bus" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsDynamodbTestClient


@given('an "eventbridge" "bus" is created')
def events_ddb_bus_has_been_created(lws_session):
    EventsDynamodbTestClient(lws_session).create_bus()
