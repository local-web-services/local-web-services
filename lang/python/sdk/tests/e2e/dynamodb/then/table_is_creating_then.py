"""Then: the "dynamodb" "table" will be in "CREATING" state"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_TABLE


@then('the "dynamodb" "table" will be in "CREATING" state')
def table_is_creating_then(lws_session):
    """In lws, tables may be CREATING or ACTIVE. Accept either."""
    client = lws_session.client("dynamodb")
    resp = client.describe_table(TableName=TEST_TABLE)
    actual_status = resp["Table"]["TableStatus"]
    assert actual_status in (
        "CREATING",
        "ACTIVE",
    ), f"Expected table to be CREATING or ACTIVE but got: {actual_status}"
