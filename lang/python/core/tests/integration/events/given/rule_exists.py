"""Given: the rule exists."""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import EventsTestClient


@given("the rule exists")
def rule_exists(client: TestClient):
    EventsTestClient(client).create_bus()
    EventsTestClient(client).create_rule()
