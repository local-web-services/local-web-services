"""Given: fid not in callee_status"""

from __future__ import annotations

from pytest_bdd import given


@given("fid not in callee_status")
def fid_not_in_callee_status():
    """No-op: fresh state has no callee functions."""
