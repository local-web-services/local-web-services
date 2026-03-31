"""Then: the "dynamodb" "table" will be "ACTIVE" and ready for reads and writes"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..client import DynamodbTestClient
from ..constants import TEST_TABLE


@then('the "dynamodb" "table" will be "ACTIVE" and ready for reads and writes')
def table_is_active_then(client: TestClient):
    r = DynamodbTestClient(client).post("ListTables", {})
    actual_tables = r.json().get("TableNames", [])
    assert (
        TEST_TABLE in actual_tables
    ), f"Expected table '{TEST_TABLE}' to be ACTIVE but not found in: {actual_tables}"
