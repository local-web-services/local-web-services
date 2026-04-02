"""Given: the "rds" "instance" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "rds" "instance" did not already exist')
def rds_lambda_db_not_already_exist():
    """No-op: fresh state has no DB instances."""
