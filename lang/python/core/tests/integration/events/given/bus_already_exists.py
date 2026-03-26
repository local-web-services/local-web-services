"""Given: the event bus already exists."""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import EventsTestClient


@given("the event bus already exists")
def bus_already_exists(client: TestClient):
    EventsTestClient(client).create_bus()
