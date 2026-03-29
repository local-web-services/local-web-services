"""Given: sid not in server_status"""

from __future__ import annotations

from pytest_bdd import given


@given("sid not in server_status")
def sid_not_in_server_status():
    """No-op: fresh state has no fake servers."""
