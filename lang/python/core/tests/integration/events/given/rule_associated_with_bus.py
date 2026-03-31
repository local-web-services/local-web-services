"""Given: a rule is associated with the event bus."""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import EventsTestClient


@given('an "eventbridge" "rule" is associated with the "eventbridge" "bus"')
def rule_associated_with_bus(client: TestClient):
    EventsTestClient(client).create_rule()
