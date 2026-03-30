"""Given: pid not in pool_status"""

from __future__ import annotations

from pytest_bdd import given


@given("pid not in pool_status")
def cognito_lambda_pid_not_in_pool_status():
    """No-op: fresh state has no user pools."""
