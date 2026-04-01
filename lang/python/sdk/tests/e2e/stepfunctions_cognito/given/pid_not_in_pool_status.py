"""Given: pid not in pool_status"""

from __future__ import annotations

from pytest_bdd import given


@given("pid not in pool_status")
def pid_not_in_pool_status():
    """No-op: guard condition — fresh state has no user pools."""
