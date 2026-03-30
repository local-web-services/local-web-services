"""Given: busid not in bus_status"""

from __future__ import annotations

from pytest_bdd import given


@given("busid not in bus_status")
def busid_not_in_bus_status():
    """No-op: fresh state has no custom buses."""
