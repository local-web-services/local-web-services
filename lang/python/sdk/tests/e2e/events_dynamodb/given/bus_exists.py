"""Given: the "eventbridge" "rule" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsDynamodbTestClient


@given('the "eventbridge" "rule" existed')
def bus_exists(lws_session):
    EventsDynamodbTestClient(lws_session).create_bus()
