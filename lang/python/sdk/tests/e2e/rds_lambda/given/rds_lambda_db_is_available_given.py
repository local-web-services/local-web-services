"""Given: the "DB" instance is "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "DB" instance is "AVAILABLE"')
def rds_lambda_db_is_available_given():
    """No-op: DB instances are available by default in lws."""
