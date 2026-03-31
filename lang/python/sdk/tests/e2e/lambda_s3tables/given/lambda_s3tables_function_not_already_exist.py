"""Given: the "lambda" "function" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "lambda" "function" did not already exist')
def lambda_s3tables_function_not_already_exist():
    """No-op: fresh state has no Lambda functions."""
