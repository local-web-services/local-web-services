"""Given: the table does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the table does not exist")
def lambda_s3tables_table_does_not_exist():
    """No-op: fresh state has no S3 Tables tables."""
