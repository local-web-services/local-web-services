"""Given: the event bus exists."""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import EventsTestClient


@given('the "eventbridge" "bus" existed')
def bus_exists(client: TestClient):
    EventsTestClient(client).create_bus()
