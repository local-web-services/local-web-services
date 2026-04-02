"""Given: the "rds" "DB instance" was "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "rds" "DB instance" was "AVAILABLE"')
@given('the "rds" "instance" was "AVAILABLE"')
def rds_lambda_db_is_available_given():
    """No-op: DB instances are available by default in lws."""
