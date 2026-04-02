"""Then: the "s3 tables" "table" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_TABLE, _table_bucket_arn


@then('the "s3 tables" "table" will be "ACTIVE"')
def lambda_s3tables_table_is_active_then(lws_session):
    resp = lws_session.client("s3tables").list_tables(tableBucketARN=_table_bucket_arn())
    actual_tables = [t["name"] for t in resp.get("tables", [])]
    expected_table = TEST_TABLE
    assert (
        expected_table in actual_tables
    ), f"Expected table '{expected_table}' to be ACTIVE but not found in: {actual_tables}"
