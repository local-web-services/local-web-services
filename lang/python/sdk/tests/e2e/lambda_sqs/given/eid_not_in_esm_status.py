"""Given: eid not in esm_status"""

from __future__ import annotations

from pytest_bdd import given


@given("eid not in esm_status")
def eid_not_in_esm_status():
    """No-op: fresh state has no event source mappings."""
