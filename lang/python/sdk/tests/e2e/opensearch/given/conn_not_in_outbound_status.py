"""Given: conn not in outbound_status"""

from __future__ import annotations

from pytest_bdd import given


@given("conn not in outbound_status")
def conn_not_in_outbound_status():
    """No-op: fresh state has no outbound connections."""
