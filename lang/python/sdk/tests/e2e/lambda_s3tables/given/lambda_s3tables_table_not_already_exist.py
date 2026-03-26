"""Given: the table does not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the table does not already exist")
def lambda_s3tables_table_not_already_exist():
    """No-op: fresh state has no S3 Tables tables."""
