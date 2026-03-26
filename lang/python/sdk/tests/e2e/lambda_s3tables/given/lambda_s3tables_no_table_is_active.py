"""Given: no table is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('no table is "ACTIVE"')
def lambda_s3tables_no_table_is_active():
    """No-op: fresh state has no S3 Tables tables."""
