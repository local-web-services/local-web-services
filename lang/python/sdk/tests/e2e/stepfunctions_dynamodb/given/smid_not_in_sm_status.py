"""Given: smid not in sm_status"""

from __future__ import annotations

from pytest_bdd import given


@given("smid not in sm_status")
def smid_not_in_sm_status():
    """No-op: guard condition — fresh state has no state machines."""
