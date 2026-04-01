"""Given: rgid not in rg_status"""

from __future__ import annotations

from pytest_bdd import given


@given("rgid not in rg_status")
def rgid_not_in_rg_status():
    """No-op: fresh state has no replication groups."""
