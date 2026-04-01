"""Given: the "lambda" "function" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "lambda" "function" did not exist')
def lambda_s3tables_function_does_not_exist():
    """No-op: fresh state has no Lambda functions."""
