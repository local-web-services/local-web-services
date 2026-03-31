"""Then: the table is deleted"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..client import DynamodbTestClient
from ..constants import TEST_TABLE


@then("the table is deleted")
@then('the "dynamodb" "table" will be in "DELETING" state and all its items will be removed')
def table_is_deleted_then(client: TestClient):
    r = DynamodbTestClient(client).post("ListTables", {})
    actual_tables = r.json().get("TableNames", [])
    assert (
        TEST_TABLE not in actual_tables
    ), f"Expected table '{TEST_TABLE}' to be deleted but found in: {actual_tables}"
