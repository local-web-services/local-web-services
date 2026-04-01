"""Given: the rule already exists."""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import EventsTestClient


@given('the "eventbridge" "rule" already existed')
def rule_already_exists(client: TestClient):
    EventsTestClient(client).create_bus()
    EventsTestClient(client).create_rule()
