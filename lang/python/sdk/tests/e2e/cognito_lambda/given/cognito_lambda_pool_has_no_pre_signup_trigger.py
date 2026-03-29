"""Given: the pool has no pre-signup trigger configured"""

from __future__ import annotations

from pytest_bdd import given


@given("the pool has no pre-signup trigger configured")
def cognito_lambda_pool_has_no_pre_signup_trigger():
    """No-op: pools have no pre-signup trigger configured by default."""
