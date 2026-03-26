"""Then: the table is "ACTIVE" and ready for reads and writes"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_TABLE


@then('the table is "ACTIVE" and ready for reads and writes')
def table_is_active_then(lws_session):
    client = lws_session.client("dynamodb")
    resp = client.list_tables()
    actual_tables = resp.get("TableNames", [])
    assert (
        TEST_TABLE in actual_tables
    ), f"Expected table '{TEST_TABLE}' to be ACTIVE but not found in: {actual_tables}"
