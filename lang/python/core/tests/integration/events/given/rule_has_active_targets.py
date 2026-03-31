"""Given: the rule has active targets."""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import EventsTestClient


@given('the "eventbridge" "rule" has active targets')
def rule_has_active_targets(client: TestClient):
    EventsTestClient(client).put_target()
