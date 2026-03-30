"""Given: the function does not exist or is not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the function does not exist or is not "ACTIVE"')
def rds_lambda_function_not_exist_or_not_active():
    """No-op: fresh state has no functions."""
