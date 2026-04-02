"""Given: the "eventbridge" "bus" is deleted"""

from __future__ import annotations

from pytest_bdd import given


@given('the "eventbridge" "bus" is deleted')
def lambda_events_seq_bus_deleted():
    """No-op: fresh state has no buses, simulates a previously deleted bus."""
