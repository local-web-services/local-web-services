"""Then: the "dynamodb" "table" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_TABLE


@then('the "dynamodb" "table" will be "ACTIVE"')
def table_is_active_then(lws_session):
    resp = lws_session.client("dynamodb").list_tables()
    actual_tables = resp.get("TableNames", [])
    assert (
        TEST_TABLE in actual_tables
    ), f"Expected table '{TEST_TABLE}' to be ACTIVE but not found in: {actual_tables}"
