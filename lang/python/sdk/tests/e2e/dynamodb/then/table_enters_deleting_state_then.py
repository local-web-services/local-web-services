"""Then: the table enters "DELETING" state and all its items are removed"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_TABLE


@then('the table enters "DELETING" state and all its items are removed')
def table_enters_deleting_state_then(lws_session, world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected delete operation to succeed but got: {actual_error}"
    client = lws_session.client("dynamodb")
    resp = client.list_tables()
    actual_tables = resp.get("TableNames", [])
    assert (
        TEST_TABLE not in actual_tables
    ), f"Expected table '{TEST_TABLE}' to be removed but found in: {actual_tables}"
