"""Given: pool_id not in pool_status"""

from __future__ import annotations

from pytest_bdd import given


@given("pool_id not in pool_status")
def cognito_idp_pool_id_not_in_pool_status():
    """No-op: fresh state has no user pools."""
