"""Given: a target is associated with the rule."""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import EventsTestClient


@given("a target is associated with the rule")
def target_associated_with_rule(client: TestClient):
    EventsTestClient(client).put_target()
