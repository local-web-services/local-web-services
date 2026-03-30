"""Given: the "DB" instance has no Lambda integration configured"""

from __future__ import annotations

from pytest_bdd import given


@given('the "DB" instance has no Lambda integration configured')
def rds_lambda_db_has_no_integration():
    """No-op: DB instances have no Lambda integration by default."""
