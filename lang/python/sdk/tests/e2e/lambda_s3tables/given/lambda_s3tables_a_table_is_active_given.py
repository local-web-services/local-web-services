"""Given: a table is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('a table is "ACTIVE"')
def lambda_s3tables_a_table_is_active_given():
    """No-op: in lws, S3Tables tables are ACTIVE by default."""
