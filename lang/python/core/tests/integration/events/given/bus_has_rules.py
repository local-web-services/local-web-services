"""Given: the event bus has rules."""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import EventsTestClient


@given('the "eventbridge" "bus" has rules')
def bus_has_rules(client: TestClient):
    EventsTestClient(client).create_rule()
