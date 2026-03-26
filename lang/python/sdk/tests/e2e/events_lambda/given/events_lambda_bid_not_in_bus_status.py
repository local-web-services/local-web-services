"""Given: bid not in bus_status"""

from __future__ import annotations

from pytest_bdd import given


@given("bid not in bus_status")
def events_lambda_bid_not_in_bus_status():
    """No-op: fresh state has no event buses."""
