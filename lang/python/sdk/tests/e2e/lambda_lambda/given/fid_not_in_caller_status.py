"""Given: fid not in caller_status"""

from __future__ import annotations

from pytest_bdd import given


@given("fid not in caller_status")
def fid_not_in_caller_status():
    """No-op: fresh state has no caller functions."""
