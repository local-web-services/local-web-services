"""Given: the EventBridge event bus has been deleted"""

from __future__ import annotations

from pytest_bdd import given


@given("the EventBridge event bus has been deleted")
def lambda_events_seq_bus_deleted():
    """No-op: fresh state has no buses, simulates a previously deleted bus."""
