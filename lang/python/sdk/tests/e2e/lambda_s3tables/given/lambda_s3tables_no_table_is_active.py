"""Given: no table was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('no table was "ACTIVE"')
def lambda_s3tables_no_table_is_active():
    """No-op: fresh state has no S3 Tables tables."""
